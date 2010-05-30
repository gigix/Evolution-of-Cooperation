require File.dirname(__FILE__) + "/spec_helper"

describe Dilemma do
  before(:each) do
    @p1 = Prisoner.new
    @p2 = Prisoner.new
    @dilemma = Dilemma.new(@p1, @p2)
  end
  
  describe :play! do
    it "increases scores of both prisoners" do
      @p1.score.should == 0
      @p2.score.should == 0
      
      @dilemma.play!
      
      @p1.score.should == 3
      @p2.score.should == 3
    end
    
    it "rewards single betrayer" do
      betrayer = Prisoner.new(AlwaysBetrayStrategy.new)
      dilemma = Dilemma.new(@p1, betrayer)

      dilemma.play!
      
      @p1.score.should == 0
      betrayer.score.should == 5
    end
    
    it "hurts both betrayers" do
      betrayer_1 = Prisoner.new(AlwaysBetrayStrategy.new)
      betrayer_2 = Prisoner.new(AlwaysBetrayStrategy.new)
      dilemma = Dilemma.new(betrayer_1, betrayer_2)
      
      dilemma.play!
      
      betrayer_1.score.should == 1
      betrayer_2.score.should == 1
    end
  end  
end