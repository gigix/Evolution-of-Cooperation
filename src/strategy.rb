class Strategy
  def decide(my_history, opponent_history)
    raise "Override this method, please."
  end
end

class AlwaysCooperateStrategy < Strategy
  def decide(my_history, opponent_history)
    Action.cooperative
  end
end

class AlwaysBetrayStrategy < Strategy
  def decide(my_history, opponent_history)
    Action.treacherous
  end
end

class TitForTatStrategy < Strategy
  def decide(my_history, opponent_history)
    last_opponent_action = opponent_history.last
    return Action.cooperative if last_opponent_action.nil? or last_opponent_action.cooperative?
    return Action.treacherous
  end
end