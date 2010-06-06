require File.dirname(__FILE__) + "/spec_helper"

describe Competition do
  describe :play! do
    it "plays Prisoners' Dilemma around given strategies given times" do
      tit_for_tat = TitForTatStrategy.new
      always_betray = AlwaysBetrayStrategy.new
      competition = Competition.new([tit_for_tat, always_betray], 10)
      result = competition.play!
      
      result.should_not be_nil
      result[tit_for_tat][always_betray].should == 9
      result[always_betray][tit_for_tat].should == 14
      result[always_betray][always_betray].should == 10
      result[tit_for_tat][tit_for_tat].should == 30
      result.strategies.should == [tit_for_tat, always_betray]
    end
    
    it "supports multiple strategies of same class" do
      competition = Competition.new([TitForTatStrategy.new, TitForTatStrategy.new], 10)
      result = competition.play!
      
      result.strategies.should have(2).strategies
    end
    
    [22, 31, 59, 101].each do |amount_of_strategy_instances|
      it "plays well for #{amount_of_strategy_instances} strategy instances" do
        strategies = (1..amount_of_strategy_instances).map{ AlwaysCooperateStrategy.new }
        competition = Competition.new(strategies, 10)
        result = competition.play!
      
        result.strategies.each do |strategy|
          result.total(strategy).should == 30 * amount_of_strategy_instances
        end
      end
    end
  end
end

describe Result do
  describe :highest_score_of do
    it "returns highest total score within instances of given strategy class" do
      strategy_1 = Strategy.new
      strategy_2 = Strategy.new
      result = Result.new([strategy_1, strategy_2])
      
      result[strategy_1][strategy_1] = 10
      result[strategy_1][strategy_2] = 10
      result[strategy_2][strategy_1] = 5
      result[strategy_2][strategy_2] = 5
      
      result.highest_score_of(Strategy).should == 20
    end
  end
end