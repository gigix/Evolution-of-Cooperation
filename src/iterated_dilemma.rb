class IteratedDilemma
  def initialize(prisoner_1, prisoner_2, times)
    @dilemma = Dilemma.new(prisoner_1, prisoner_2)
    @times = times
    @history_storage = {prisoner_1 => [], prisoner_2 => []}
  end
  
  def play!
    @times.times do 
      @dilemma.play!(@history_storage)
    end
  end
  
  def history(prisoner)
    @history_storage[prisoner]
  end
end