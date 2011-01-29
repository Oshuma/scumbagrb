$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'cinch'
require 'mongoid'
require 'yaml'

require 'scumbag/commands'
require 'scumbag/models'

# TODO: Live bot admin.
# TODO: Dynamic code reloading.
module Scumbag
  VERSION = '0.1.0'

  def self.options
    @@options = {} unless defined?(@@options)
    @@options
  end

  # Configures Scumbag with the given +config_file+.
  def self.setup!(config_file)
    @@options = ::YAML.load_file(config_file)
    configure_database
  end

  # Create and return a Cinch::Bot instance from the given +config_file+.
  def self.create_bot(config_file)
    setup!(config_file)

    bot = ::Cinch::Bot.new do
      configure do |c|
        c.plugins.plugins = [ Commands::Links ]
        c.plugins.prefix = @@options['prefix'] if @@options['prefix']

        c.server   = @@options['server']
        c.port     = @@options['port']
        c.nick     = @@options['nick']
        c.channels = @@options['channels']

        # SSL shit.
        if @@options['ssl']
          c.ssl.use = @@options['ssl']['use']
          if @@options['ssl']['verify']
            c.ssl.verify = @@options['ssl']['verify']
          end
        end
      end
    end

    bot
  end

  private

  def self.configure_database
    return unless @@options['database']
    ::Mongoid.configure do |config|
      config.from_hash(@@options['database'])
      if @@options['database']['log']
        config.logger = Logger.new(@@options['database']['log'])
      end
    end
  end

end
