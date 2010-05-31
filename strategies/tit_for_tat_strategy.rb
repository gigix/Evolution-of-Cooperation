class TitForTatStrategy < Strategy
  def to_operate?(my_history, opponent_history)
    last_opponent_action = opponent_history.last
    last_opponent_action.nil? or last_opponent_action.cooperative?
  end
end