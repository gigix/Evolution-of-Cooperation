class TitForTwoTats < Strategy
  def to_operate?(my_history, opponent_history)
    last_opponent_action = opponent_history.last
    previous_opponent_action = opponent_history[opponent_history.length - 2]
    last_opponent_action.nil? or last_opponent_action.cooperative? or previous_opponent_action.nil? or previous_opponent_action.cooperative?
  end
end