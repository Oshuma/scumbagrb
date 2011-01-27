module Scumbag
  class Links
    include Cinch::Plugin

    URL_REGEXP = /((ftp|git|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(?:\/|\/([\w#!:.?+=&%@!\-\/]))?)/

    # Command name.
    plugin 'links'

    # Command pattern: <prefix>url
    match 'url'

    help 'Usage: url /pattern/'

    listen_to :channel, :method => :channel_message

    # Execute a <em>match</em>ed command.
    def execute(m)
      bot.logger.debug "Command: #{m.inspect}"
    end

    # Handles channel messages.
    def channel_message(m)
      url_match = m.message.match(URL_REGEXP)
      log_url(url_match[1], m) if url_match
    end

    private

    def log_url(url, message)
      attrs = {
        :url => url,
        :nick => message.user.nick,
        :timestamp => Time.now,
      }
      bot.logger.debug "log_url(): attrs: #{attrs.inspect}"
    end

  end
end
