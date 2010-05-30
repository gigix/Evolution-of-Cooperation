require File.dirname(__FILE__) + "/spec_helper"

describe TitForTatStrategy do
  describe :decide do
    it "cooperates if previous opponent action is unknown or cooperative" do
      strategy = TitForTatStrategy.new
      strategy.decide([], []).should be_cooperative
      strategy.decide([Action.cooperative], [Action.cooperative]).should be_cooperative
    end
    
    it "betrays if previous opponent action is treacherous" do
      strategy = TitForTatStrategy.new
      strategy.decide([Action.cooperative], [Action.treacherous]).should be_treacherous
    end
  end
end