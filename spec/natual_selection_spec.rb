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
    it "decides percentage of next generation based on scores of current generation"
  #     natual_selection = NatualSelection.new(AlwaysCooperateStrategy.new, AlwaysBetrayStrategy.new, TitForTatStrategy.new)
  #     natual_selection.instance_variable_get(:competition).should_receive(:play!).and_return
  #     
  #     natual_selection.evolve!
  #   end
  end
end