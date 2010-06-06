class NatualSelection
  DEFAULT_AMOUNT_OF_INSTANCES = 1000
  
  def initialize(strategy_classes, amount_of_instances = DEFAULT_AMOUNT_OF_INSTANCES)
    @strategy_classes = strategy_classes.uniq
    
    initial_instance_number = amount_of_instances / @strategy_classes.length
    @strategies = []
    @strategy_classes.each{|clazz| initial_instance_number.times{ @strategies << clazz.new}}
  end  
  
  def play!
    competition = Competition.new(@strategies)
    raw_result = competition.play!
    result = {}
    @strategy_classes.each{|clazz| result[clazz] = raw_result.highest_score_of(clazz)}
    result
  end
end