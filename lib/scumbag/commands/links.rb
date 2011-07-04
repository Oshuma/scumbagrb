module Scumbag
  module Commands
    class Links
      include Cinch::Plugin

      URL_REGEXP = /((ftp|git|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(?:\/|\/([\w#!:.?+=&%@!\-\/]))?)/

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
        @links = Models::Link.search(query)
        m.reply(@links.map(&:url).join(' | '))
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
