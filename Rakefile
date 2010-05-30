require 'rake'
require 'rake/testtask'

def exec(cmd)
  success = system(cmd)
  raise "System command execution failed!" unless success
end

import File.expand_path(File.dirname(__FILE__) + "/lib/tasks/git.rake")

task :default => [:spec]

task :spec do
  exec "spec spec/"
end