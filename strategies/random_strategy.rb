class RandomStrategy < Strategy
  def to_operate?(my_history, opponent_history)
    rand(2) == 0
  end
end