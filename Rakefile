require 'rake'
require 'rake/testtask'

require File.dirname(__FILE__) + "/boot"

def exec(cmd)
  success = system(cmd)
  raise "System command execution failed!" unless success
end

import File.expand_path(File.dirname(__FILE__) + "/lib/tasks/git.rake")

task :default => [:spec, :competition]

task :spec do
  exec "spec spec/"
end

task :competition do
  competitors = [
    AlwaysCooperateStrategy,
    AlwaysBetrayStrategy, 
    TitForTatStrategy, 
    # NeverForgive,
    # Joss,
    # TitForTwoTats,
    # RandomStrategy
  ].map{|clazz| clazz.new}
  competition = Competition.new(competitors)
  
  result = competition.play!
  puts "Champion is #{result.strategies.first}, whose total score is #{result.total(result.strategies.first)}."
  
  result_dir = File.dirname(__FILE__) + "/result"
  mkdir_p result_dir
  File.open("#{result_dir}/competition_result.csv", "w"){|f| f.write(result.to_s)}
  puts "Check #{result_dir} directory for detailed report."
end