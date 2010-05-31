class IteratedDilemma
  def self.build(strategy_class_1, strategy_class_2, times)
    IteratedDilemma.new(Prisoner.new(strategy_class_1.new), Prisoner.new(strategy_class_2.new), times)
  end
  
  def initialize(prisoner_1, prisoner_2, times)
    @prisoner_1 = prisoner_1
    @prisoner_2 = prisoner_2
    @times = times
    
    @dilemma = Dilemma.new(@prisoner_1, @prisoner_2)
    @history_storage = {@prisoner_1 => [], @prisoner_2 => []}
  end
  
  def play!
    @times.times do 
      @dilemma.play!(@history_storage)
    end
    [@prisoner_1.score, @prisoner_2.score]
  end
  
  def history(prisoner)
    @history_storage[prisoner]
  end
end