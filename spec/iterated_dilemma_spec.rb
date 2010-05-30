require File.dirname(__FILE__) + "/spec_helper"

describe IteratedDilemma do
  describe :play do
    it "plays Prisoners' Dilemma multiple times" do
      cooperator_1 = Prisoner.new(AlwaysCooperateStrategy.new)
      cooperator_2 = Prisoner.new(AlwaysCooperateStrategy.new)
      iterated_dilemma = IteratedDilemma.new(cooperator_1, cooperator_2, 10)
      
      iterated_dilemma.play!
      
      cooperator_1.score.should == 30
      cooperator_2.score.should == 30
    end
    
    describe "feeds history to prisoners" do
      it "makes TFT prisoner be treacherous to a betrayer" do
        betrayer = Prisoner.new(AlwaysBetrayStrategy.new)
        tft_prisoner = Prisoner.new(TitForTatStrategy.new)
        iterated_dilemma = IteratedDilemma.new(betrayer, tft_prisoner, 10)
        
        iterated_dilemma.play!
        
        iterated_dilemma.history(tft_prisoner).last.should be_treacherous
        iterated_dilemma.history(tft_prisoner).first.should be_cooperative
        
        tft_prisoner.score.should == 9
        betrayer.score.should == 14
      end
      
      it "makes TFT prisoner be cooperative to a cooperator" do
        cooperator = Prisoner.new(AlwaysCooperateStrategy.new)
        tft_prisoner = Prisoner.new(TitForTatStrategy.new)
        iterated_dilemma = IteratedDilemma.new(tft_prisoner, cooperator, 10)
        
        iterated_dilemma.play!
        
        cooperator.score.should == 30
        tft_prisoner.score.should == 30
      end
    end
  end
  
  describe :history do
    it "returns action history of given prisoner" do
      cooperator = Prisoner.new(AlwaysCooperateStrategy.new)
      betrayer = Prisoner.new(AlwaysBetrayStrategy.new)
      iterated_dilemma = IteratedDilemma.new(cooperator, betrayer, 10)
      
      iterated_dilemma.history(cooperator).should be_empty
      iterated_dilemma.history(betrayer).should be_empty
      
      iterated_dilemma.play!
      
      iterated_dilemma.history(cooperator).should have(10).records
      10.times{|i| iterated_dilemma.history(cooperator)[i].should be_cooperative}
      iterated_dilemma.history(betrayer).should have(10).records
      10.times{|i| iterated_dilemma.history(betrayer)[i].should be_treacherous}
    end
  end
end