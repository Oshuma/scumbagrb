module Scumbag
  module Commands
    class BaseCommand
      # Returns an array of arguments to the command.
      def extract_args(m)
        command = Regexp.escape("#{self.class.prefix}#{self.class.plugin_name}")
        m.message.gsub(/^#{command}/, '').strip
      end
    end
  end
end
