Dir[File.dirname(__FILE__) + "/src/**/*.rb", File.dirname(__FILE__) + "/strategies/**/*.rb"].each do |source_file|
  require source_file
end