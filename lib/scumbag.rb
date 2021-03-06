$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'cinch'
require 'geokit'
require 'ipaddr'
require 'mongoid'
require 'yaml'

require 'scumbag/commands'
require 'scumbag/models'

# TODO: Live bot admin.
# TODO: Dynamic code reloading.
module Scumbag
  VERSION = '0.2.0'

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
        # This is where each Command class should be added.
        # TODO: Allow dynamic loading of plugins; also, move this array to a config or some shit.
        c.plugins.plugins = [
          Scumbag::Commands::GeoIP,
          Scumbag::Commands::Links,
          Scumbag::Commands::SpellCheck
        ]
        c.plugins.prefix = @@options['prefix'] if @@options['prefix']

        c.server   = @@options['server']
        c.port     = @@options['port']
        c.nick     = @@options['nick']
        c.user     = @@options['user']     if @@options['user']
        c.realname = @@options['realname'] if @@options['realname']
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
