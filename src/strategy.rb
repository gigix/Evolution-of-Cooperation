class Strategy
  def decide(my_history, opponent_history)
    to_operate?(my_history, opponent_history) ? Action.cooperative : Action.treacherous
  end
  
  protected
  def to_operate?(my_history, opponent_history)
    raise "Override this method to implement your strategy."
  end
end

class AlwaysCooperateStrategy < Strategy
  def to_operate?(my_history, opponent_history)
    true
  end
end

class AlwaysBetrayStrategy < Strategy
  def to_operate?(my_history, opponent_history)
    false
  end
end

class TitForTatStrategy < Strategy
  def to_operate?(my_history, opponent_history)
    last_opponent_action = opponent_history.last
    last_opponent_action.nil? or last_opponent_action.cooperative?
  end
end

class RandomStrategy < Strategy
  def to_operate?(my_history, opponent_history)
    rand(2) == 0
  end
end