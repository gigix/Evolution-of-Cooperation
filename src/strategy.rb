class Strategy
  def decide
    raise "Override this method, please."
  end
end

class AlwaysCooperateStrategy < Strategy
  def decide
    Action.cooperative
  end
end

class AlwaysBetrayStrategy < Strategy
  def decide
    Action.treacherous
  end
end