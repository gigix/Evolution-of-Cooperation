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