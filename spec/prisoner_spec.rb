require File.dirname(__FILE__) + "/spec_helper"

describe Prisoner do
  describe :decide do
    it "returns cooperative action by default" do
      prisoner = Prisoner.new
      prisoner.decide.should be_cooperative
      prisoner.decide.should_not be_treacherous
    end
    
    it "returns treacherous action if the prisoner's strategy is always betray" do
      prisoner = Prisoner.new(AlwaysBetrayStrategy.new)
      prisoner.decide.should be_treacherous
    end
  end
  
  describe :count! do
    before(:each) do
      @prisoner = Prisoner.new
      @prisoner.score.should == 0      
    end
    
    it "increases score by 3 if both prisoners are cooperative" do
      @prisoner.count!(Action.cooperative, Action.cooperative)
      @prisoner.score.should == 3
    end
    
    it "increases score by 5 if I betray another prisoner" do
      @prisoner.count!(Action.treacherous, Action.cooperative)
      @prisoner.score.should == 5
    end
    
    it "increases score by 0 if I'm betrayed" do
      @prisoner.count!(Action.cooperative, Action.treacherous)
      @prisoner.score.should == 0
    end
    
    it "increases score by 1 if both are betrayed" do
      @prisoner.count!(Action.treacherous, Action.treacherous)
      @prisoner.score.should == 1
    end
  end
end