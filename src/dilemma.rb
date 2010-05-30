class Dilemma
  def initialize(prisoner_1, prisoner_2)
    @prisoner_1 = prisoner_1
    @prisoner_2 = prisoner_2
  end
  
  def play!
    action_1 = @prisoner_1.decide
    action_2 = @prisoner_2.decide
        
    @prisoner_1.count!(action_1, action_2)
    @prisoner_2.count!(action_2, action_1)
  end
end