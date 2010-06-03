class NatualSelection
  def initialize(strategy_classes)
    @strategy_classes = strategy_classes.uniq
    
    initial_instance_number = (1000.0 / @strategy_classes.length).to_i
    @strategies = []
    @strategy_classes.each{|clazz| initial_instance_number.times{ @strategies << clazz.new}}
  end  
  
  
end