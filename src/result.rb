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