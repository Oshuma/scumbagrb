require 'bundler'
require 'rspec/core/rake_task'

require 'scumbag'

task :default => :spec

desc 'Run the specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Open an IRB session with the library loaded'
task :console => ['scumbag:console']

desc 'Run the bot (in the foreground)'
task :run => [ 'scumbag:run' ]

namespace :scumbag do
  task :setup do
    @config_file = "#{File.dirname(__FILE__)}/config/scumbag.yml"
  end

  task :run => ['scumbag:setup'] do
    @scumbag = Scumbag.create_bot(@config_file)
    @scumbag.start
  end

  task :console => ['scumbag:setup'] do
    STDOUT.puts "\nRun 'Scumbag.setup!(\"#{@config_file}\")' before interacting with the database!\n\n"
    sh "irb -I ./lib -r 'scumbag'"
  end
end

namespace :db do
  desc 'Run the database migrations'
  task :migrate => ['scumbag:setup'] do
    Scumbag.setup!(@config_file)
    Scumbag.run_migrations!
  end
end
