class Dilemma
  def initialize(prisoner_1, prisoner_2)
    @prisoner_1 = prisoner_1
    @prisoner_2 = prisoner_2
  end
  
  def play!(history_storage = nil)
    history_1 = history_storage[@prisoner_1] rescue []
    history_2 = history_storage[@prisoner_2] rescue []
    
    action_1 = @prisoner_1.decide(history_1.clone, history_2.clone)
    action_2 = @prisoner_2.decide(history_2.clone, history_1.clone)
        
    @prisoner_1.count!(action_1, action_2)
    @prisoner_2.count!(action_2, action_1)
    
    history_1 << action_1
    history_2 << action_2
  end
end