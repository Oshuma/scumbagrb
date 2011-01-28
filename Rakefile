require "#{File.dirname(__FILE__)}/lib/scumbag"

task :default => :run

desc 'Run the bot (in the foreground)'
task :run => [ 'scumbag:run' ]

namespace :scumbag do
  task :setup do
    config_file = "#{File.dirname(__FILE__)}/config/scumbag.yml"
    @scumbag = Scumbag.create_bot(config_file)
  end

  task :run => [ 'scumbag:setup' ] do
    @scumbag.start
  end
end
