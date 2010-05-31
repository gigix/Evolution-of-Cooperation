class Competition
  def initialize(times, strategies)
    @times = times
    @strategies = strategies    
    @result = Result.new(@strategies)
  end
  
  def play!
    @strategies.each_with_index do |row, row_index|
      @strategies.each_with_index do |column, column_index|
        next if column_index <= row_index
        iterated_dilemma = IteratedDilemma.build(row, column, @times)
        score1, score2 = iterated_dilemma.play!
        @result[row][column] = score1
        @result[column][row] = score2
      end
    end
    @result
  end
end

class Result
  def initialize(strategies)
    @result_hash = {}
    strategies.each do |strategy|
      @result_hash[strategy] = {}
    end
  end
  
  def [](strategy)
    @result_hash[strategy]
  end
  
  def total(strategy)
    @result_hash[strategy].values.inject(0){|sum, score| sum + score}
  end
  
  def strategies
    @result_hash.keys.sort{|strategy_1, strategy_2| total(strategy_2) <=> total(strategy_1)}
  end
  
  def to_s
    table = " , " + strategies.map{|strategy| strategy.to_s}.join(", ") + "\n"
    strategies.each do |row_strategy|
      table << row_strategy.to_s + ", " + strategies.map{|column_strategy| self[row_strategy][column_strategy].to_s}.join(", ") + "\n"
    end
    table
  end
end