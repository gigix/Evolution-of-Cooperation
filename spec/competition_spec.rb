require File.dirname(__FILE__) + "/spec_helper"

describe Competition do
  describe :play! do
    it "plays Prisoners' Dilemma around given strategies given times" do
      competition = Competition.new(10, TitForTatStrategy, AlwaysBetrayStrategy)
      result = competition.play!
      
      result.should_not be_nil
      result[TitForTatStrategy][AlwaysBetrayStrategy].should == 9
      result[AlwaysBetrayStrategy][TitForTatStrategy].should == 14
      result.strategies.should == [AlwaysBetrayStrategy, TitForTatStrategy]
    end
  end
end