class Prisoner
  attr_reader :score
  
  def initialize(strategy = AlwaysCooperateStrategy.new)
    @strategy = strategy
    @score = 0
  end
  
  def decide
    @strategy.decide
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

class Action
  def self.cooperative
    Action.new(true)
  end
  
  def self.treacherous
    Action.new(false)
  end
  
  def cooperative?
    @cooperative
  end
  
  def treacherous?
    not cooperative?
  end
  
  private
  def initialize(be_cooperative = true)
    @cooperative = be_cooperative
  end
end