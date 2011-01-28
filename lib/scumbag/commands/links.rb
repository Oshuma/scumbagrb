module Scumbag
  module Commands
    class Links
      include Cinch::Plugin

      URL_REGEXP = /((ftp|git|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(?:\/|\/([\w#!:.?+=&%@!\-\/]))?)/

      # TODO: Make this an optional arg for the command.
      LIMIT = 5

      # Command pattern: <prefix>url
      match /url/

      # Command name and help text.
      plugin 'url'
      help 'Usage: ?url nick OR /pattern/'

      listen_to :channel, :method => :channel_message

      # Called when the command is <tt>match</tt>ed.
      def execute(m)
        # TODO: Reflect the command prefix/name instead of hard coding.
        query = m.message.gsub(/^\?url/, '').strip

        # Search by Regexp.
        if query.start_with?('/') && query.end_with?('/')
          # Strip the beginning and trailing '/'
          query.gsub!(/^\//, '').gsub!(/\/$/, '')
          @links = Models::Link.where(:url => Regexp.new(query)).limit(LIMIT)
        else # It's a nick search.
          @links = Models::Link.where(:nick => query).limit(LIMIT)
        end

        bot.msg(m.channel, @links.map(&:url).join(' | '))
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

        Models::Link.create(attrs)
      end

    end
  end
end
