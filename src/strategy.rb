class Strategy
  attr_reader :id
  
  def initialize
    @id = self.class.name << ":" << rand(Time.now.to_f).to_s
  end
  
  def ==(another)
    return false unless another.class == self.class
    self.id == another.id
  end
  
  def to_s
    @id
  end
  
  def decide(my_history, opponent_history)
    to_operate?(my_history, opponent_history) ? Action.cooperative : Action.treacherous
  end
  
  protected
  def to_operate?(my_history, opponent_history)
    raise "Override this method to implement your strategy."
  end
end