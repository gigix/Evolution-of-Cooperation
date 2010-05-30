Dir[File.dirname(__FILE__) + "/../src/**/*.rb"].each do |source_file|
  require source_file
end