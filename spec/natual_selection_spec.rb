require File.dirname(__FILE__) + "/spec_helper"

describe NatualSelection do
  before(:each) do
    @strategy_classes = [AlwaysCooperateStrategy, AlwaysBetrayStrategy, TitForTatStrategy, NeverForgive]
    @natual_selection = NatualSelection.new(@strategy_classes)
  end
  
  describe :initialize do
    it "creates strategy instances evenly" do
      initial_strategies = @natual_selection.instance_variable_get("@strategies")
      initial_strategies.should have(1000).instances
      @strategy_classes.each do |clazz|
        initial_strategies.select{|strategy| strategy.class == clazz}.should have(250).instances
      end
    end 
  end
  
  describe :play! do
    it "returns highest scores of given strategies"
  #     natual_selection = NatualSelection.new([AlwaysCooperateStrategy, AlwaysBetrayStrategy, TitForTatStrategy])
  #     result = natual_selection.play!
  #     result[AlwaysCooperateStrategy].should == 1200
  #     result[AlwaysBetrayStrategy].should == 1404
  #     result[TitForTatStrategy].should == 1399
  #   end
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