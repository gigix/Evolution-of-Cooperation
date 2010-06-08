require 'rake'
require 'rake/testtask'

require File.dirname(__FILE__) + "/boot"

def exec(cmd)
  success = system(cmd)
  raise "System command execution failed!" unless success
end

def competitor_classes
  [
    # AlwaysCooperateStrategy,
    AlwaysBetrayStrategy, 
    TitForTatStrategy, 
    NeverForgive,
    Joss,
    TitForTwoTats,
    # RandomStrategy
  ]
end

import File.expand_path(File.dirname(__FILE__) + "/lib/tasks/git.rake")

task :default => [:spec, :competition]

task :spec do
  exec "spec spec/"
end

task :competition do
  competitors = competitor_classes.map{|clazz| clazz.new}
  competition = Competition.new(competitors)
  
  result = competition.play!
  puts "Champion is #{result.strategies.first}, whose total score is #{result.total(result.strategies.first)}."
  
  result_dir = File.dirname(__FILE__) + "/result"
  mkdir_p result_dir
  File.open("#{result_dir}/competition_result.csv", "w"){|f| f.write(result.to_s)}
  puts "Check #{result_dir} directory for detailed report."
end

task :natual_selection do
  natual_selection = NatualSelection.new(competitor_classes, 100)
  50.times do |i|
    natual_selection.evolve!
    puts "======= DONE GENERATION #{i} ======="
    puts natual_selection.to_s
  end
end

task :profile_natual_selection do
  natual_selection = NatualSelection.new(competitor_classes, 100)
  # natual_selection = NatualSelection.new(competitor_classes)
  
  puts "======= BEGIN AT #{Time.now} ========"
  natual_selection.play!
  puts "======= FINISH AT #{Time.now} ========"
end