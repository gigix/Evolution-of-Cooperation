class Strategy
  def decide(my_history, opponent_history)
    to_operate?(my_history, opponent_history) ? Action.cooperative : Action.treacherous
  end
  
  protected
  def to_operate?(my_history, opponent_history)
    raise "Override this method to implement your strategy."
  end
end