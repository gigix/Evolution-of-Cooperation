class Competition
  DEFAULT_TIMES = 200
  
  def initialize(strategies, times = DEFAULT_TIMES)
    @times = times
    @strategies = strategies
    @result = Result.new(@strategies)
    @size_of_section = 10
  end
  
  def play!
    # partial_play!(@strategies)
    remaining_strategies = @strategies.clone
    threads = []
    split_strategies(remaining_strategies).each do |section|
      threads << Thread.new{ partial_play!(section) }
    end
    threads.each{|thread| thread.join}
    @result
  end
  
  private
  def split_strategies(remaining_strategies)
    puts "START SPLIT: #{Time.now}"
    sections = []
    while remaining_strategies.length > @size_of_section
      head_section_size = @size_of_section / 2
      tail_section_size = @size_of_section - head_section_size
      
      section = []
      head_section_size.times{ section << remaining_strategies.shift }
      tail_section_size.times{ section << remaining_strategies.pop }
      
      sections << section
    end
    sections << remaining_strategies unless remaining_strategies.empty?    
    puts "FINISH SPLIT: #{Time.now}"
    sections
  end
  
  def partial_play!(selected_strategies)
    puts "#{Thread.current} : START AT #{Time.now}"
    selected_strategies.each do |row|
      row_index = @strategies.index(row)
      @strategies.each_with_index do |column, column_index|
        next if column_index < row_index
        # puts "#{Thread.current} : START #{row_index} - #{column_index} <#{Time.now}>"
        iterated_dilemma = IteratedDilemma.build(row, column, @times)
        score1, score2 = iterated_dilemma.play!
        @result[row][column] = score1
        @result[column][row] = score2
        # puts "#{Thread.current} : END #{row_index} - #{column_index} <#{Time.now}>"
      end
    end
    puts "#{Thread.current} : END AT #{Time.now}"
  end
end

class Result
  def initialize(strategies)
    @result_rows = {}
    strategies.each do |strategy|
      @result_rows[strategy] = {}
    end
  end
  
  def [](strategy)
    @result_rows[strategy]
  end
  
  def total(strategy)
    @result_rows[strategy].values.inject(0){|sum, score| sum + score}
  end
  
  def highest_score_of(strategy_class)
    total(strategies(strategy_class).first)
  end
  
  def strategies(of_class = nil)
    candidates = @result_rows.keys
    candidates = @result_rows.keys.select{|strategy| strategy.class == of_class} if of_class
    candidates.sort{|strategy_1, strategy_2| total(strategy_2) <=> total(strategy_1)}
  end
  
  def to_s
    table = " , " + strategies.map{|strategy| strategy.to_s}.join(", ") + "\n"
    strategies.each do |row_strategy|
      table << row_strategy.to_s + ", " + strategies.map{|column_strategy| self[row_strategy][column_strategy].to_s}.join(", ") + "\n"
    end
    table
  end
end