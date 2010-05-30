namespace :git do
  task :add_untracked do
    status = `git status`
    untracked_lines = status.split("\n").select{|line| line =~ /^#\t/}.reject{|line| line =~ /^#\t.+:/}.map do |line|
      line.split("\t")
    end.map{|pair| pair.last}
    
    untracked_lines.each{|line| puts line}
    cmd = "git add #{untracked_lines.join(' ')}"
    system cmd
  end
end