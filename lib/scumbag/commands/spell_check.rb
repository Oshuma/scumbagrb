module Scumbag
  module Commands
    class SpellCheck
      include Cinch::Plugin

      ASPELL = '/usr/bin/aspell'
      ASPELL_MATCH = /&\s\w+\s\d+\s\d+:\s(.+)/

      # Used to check a channel message for 'word (sp?)'.
      SPELL_CHECK_MESSAGE = /(\w+)\s{1}\(sp\?\)/

      match /sp/
      plugin 'spell'
      help 'Usage: ?sp <word>'

      listen_to :channel, :method => :channel_message

      # Spell checks the given word.
      def execute(m)
        word = m.message.gsub(/^\?sp/, '').strip
        m.reply(spell_check(word))
      end

      # Checks channel messages for words followed by: (sp?)
      def channel_message(m)
        word_match = m.message.match(SPELL_CHECK_MESSAGE)
        if word_match
          word = word_match[1]
          m.reply(spell_check(word))
        end
      end

      private

      def spell_check(word)
        aspell = %x[ echo "#{word}" | #{ASPELL} pipe ]
        line   = aspell.split("\n")[1]

        # aspell's output starts with a '#' if no matches found.
        if line.start_with?('#')
          reply_msg = 'No fucking idea...'
        else
          spell_match = line.match(ASPELL_MATCH)
          reply_msg   = spell_match ? spell_match[1] : 'GJ U CAN SPELL'
        end

        "#{word}: #{reply_msg}"
      end
    end
  end
end
