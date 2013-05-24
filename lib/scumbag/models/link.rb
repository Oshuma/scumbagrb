module Scumbag
  module Models
    class Link < ActiveRecord::Base
      before_create do |l|
        l.timestamp = Time.now
      end

      attr_accessible :nick, :url, :timestamp

      # TODO: Make +count+ an arg to the command.
      def self.search(query, count = 5)
        # Search by Regexp.
        if query.start_with?('/') && query.end_with?('/')
          # Strip the beginning and trailing '/'
          query.gsub!(/^\//, '').gsub!(/\/$/, '')
          where("url LIKE '%#{query}%'").order('timestamp DESC').limit(count)
        else # It's a nick search.
          where(nick: query).order('timestamp DESC').limit(count)
        end
      end

    end
  end
end
