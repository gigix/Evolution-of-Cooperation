require File.dirname(__FILE__) + "/spec_helper"

describe NatualSelection do
  before(:each) do
    @amount_of_instances = 8
    @strategy_classes = [AlwaysCooperateStrategy, AlwaysBetrayStrategy, TitForTatStrategy, NeverForgive]
    @natual_selection = NatualSelection.new(@strategy_classes, @amount_of_instances)
  end
  
  describe :initialize do
    it "creates strategy instances evenly" do
      initial_strategies = @natual_selection.instance_variable_get("@strategies")
      initial_strategies.should have(@amount_of_instances).instances
      @strategy_classes.each do |clazz|
        initial_strategies.select{|strategy| strategy.class == clazz}.should have(@amount_of_instances / @strategy_classes.size).instances
      end
    end 
  end
  
  describe :play! do
    it "returns highest scores of given strategies" do
      result = @natual_selection.play!
      result[TitForTatStrategy].should == 3998
      result[NeverForgive].should == 3998
      result[AlwaysCooperateStrategy].should == 3600
      result[AlwaysBetrayStrategy].should == 3216
    end    
  end
  
  describe :evolve! do
    it "decides percentage of next generation based on scores of current generation" do
      @natual_selection.should_receive(:play!).and_return(
        {AlwaysCooperateStrategy => 1, AlwaysBetrayStrategy => 2, TitForTatStrategy => 3, NeverForgive => 2})
      
      @natual_selection.evolve!
      
      current_strategies = @natual_selection.instance_variable_get("@strategies")
      current_strategies.select{|strategy| strategy.class == AlwaysCooperateStrategy}.should have(1).strategy
      current_strategies.select{|strategy| strategy.class == AlwaysBetrayStrategy}.should have(2).strategies
      current_strategies.select{|strategy| strategy.class == TitForTatStrategy}.should have(3).strategies
      current_strategies.select{|strategy| strategy.class == NeverForgive}.should have(2).strategies
      
      # puts @natual_selection.to_s
    end
  end
end