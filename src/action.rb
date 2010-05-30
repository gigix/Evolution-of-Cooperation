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