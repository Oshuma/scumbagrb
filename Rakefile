require "#{File.dirname(__FILE__)}/lib/scumbag"

require 'yaml'

task :default => :run

desc 'Run the bot (in the foreground)'
task :run => [ 'scumbag:run' ]

namespace :scumbag do
  task :setup do
    config_file = "#{File.dirname(__FILE__)}/config/scumbag.yml"
    @options = YAML.load_file(config_file)
  end

  task :run => [ 'scumbag:setup' ] do
    # Reassign ivar to local, so it's available in the configure block.
    options = @options

    scumbag = Cinch::Bot.new do
      configure do |c|
        c.plugins.plugins = [ Scumbag::Links ]
        c.plugins.prefix = options['prefix'] if options['prefix']

        c.server   = options['server']
        c.port     = options['port']
        c.nick     = options['nick']
        c.channels = options['channels']

        # SSL shit.
        if options['ssl']
          c.ssl.use = options['ssl']['use']
          if options['ssl']['verify']
            c.ssl.verify = options['ssl']['verify']
          end
        end
      end
    end

    scumbag.start
  end
end
