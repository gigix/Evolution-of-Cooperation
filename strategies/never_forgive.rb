class NeverForgive < Strategy
  def to_operate?(my_history, opponent_history)
    not opponent_history.detect{|action| action.treacherous?}
  end
end