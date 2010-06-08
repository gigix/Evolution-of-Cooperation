class NatualSelection
  DEFAULT_AMOUNT_OF_INSTANCES = 1000
  
  def initialize(strategy_classes, amount_of_instances = DEFAULT_AMOUNT_OF_INSTANCES)
    @amount_of_instances = amount_of_instances
    @strategy_classes = strategy_classes.uniq
    
    initial_instance_number = @amount_of_instances / @strategy_classes.length
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
  
  def evolve!
    result = play!
    @strategies = []
    
    all_total_score = result.values.inject(0){|total, score| total + score}
    @strategy_classes.each do |clazz|
      percentage_of_strategy = result[clazz].to_f / all_total_score
      (@amount_of_instances * percentage_of_strategy).to_i.times{ @strategies << clazz.new }
    end
  end
  
  def to_s
    @strategy_classes.map do |clazz|
      "#{clazz.name} - #{@strategies.select{|strategy| strategy.class == clazz}.length}"
    end.join("\n")
  end
end