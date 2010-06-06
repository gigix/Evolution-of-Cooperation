require File.dirname(__FILE__) + "/spec_helper"

describe "System Performance" do
  before(:each) do
    Prisoner.class_eval do
      alias_method :old_count!, :count!
      
      def count!(*actions)
        @@counter ||= 0
        @@counter += 1
      end

      def self.counter
        @@counter
      end

      def self.reset!
        @@counter = 0
      end
    end

    Prisoner.reset!
  end
  
  after(:each) do
    Prisoner.class_eval do
      alias_method :count!, :old_count!
    end
  end
  
  describe "Dilemma::play!" do
    it "counts 2 times" do
      dilemma = Dilemma.new(Prisoner.new(AlwaysCooperateStrategy.new), Prisoner.new(AlwaysCooperateStrategy.new))
      dilemma.play!
      Prisoner.counter.should == 2
    end
  end
  
  describe "IteratedDilemma::play!" do
    it "counts times * 2" do
      iterated_dilemma = IteratedDilemma.build(AlwaysCooperateStrategy.new, AlwaysBetrayStrategy.new, 10)
      iterated_dilemma.play!
      Prisoner.counter.should == 20
    end
  end
  
  describe "Competition::play!" do
    it "counts (nubmer_of_players)(number_of_players + 1) * times" do
      competition = Competition.new([AlwaysCooperateStrategy.new, AlwaysBetrayStrategy.new], 10)
      competition.play!
      Prisoner.counter.should == 60
    end
  end
  
  describe "NatualSelection::play!" do
    it "counts (nubmer_of_players)(number_of_players + 1) * times" do
      amount_of_instances = 8
      strategy_classes = [AlwaysCooperateStrategy, AlwaysBetrayStrategy, TitForTatStrategy, NeverForgive]
      natual_selection = NatualSelection.new(strategy_classes, amount_of_instances)
      
      natual_selection.play!
      Prisoner.counter.should == amount_of_instances * (amount_of_instances + 1) * Competition::DEFAULT_TIMES
    end
  end
end