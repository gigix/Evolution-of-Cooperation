class Prisoner
  attr_reader :score
  
  def initialize(strategy = AlwaysCooperateStrategy.new)
    @strategy = strategy
    @score = 0
  end
  
  def decide(my_history = [], opponent_history = [])
    @strategy.decide(my_history, opponent_history)
  end
  
  def count!(my_action, opponent_action)
    if my_action.cooperative?
      @score += 3 if opponent_action.cooperative?
    else
      @score += 5 if opponent_action.cooperative?
      @score += 1 if opponent_action.treacherous?
    end
  end
end