module Scumbag
  module Models
    class Link
      include Mongoid::Document

      # Use the 'links' collection instead of namespaced name.
      store_in :links

      field :url,       :type => String
      field :nick,      :type => String
      field :timestamp, :type => Time

      # TODO: Make +count+ an arg to the command.
      def self.search(query, count = 5)
        # Search by Regexp.
        if query.start_with?('/') && query.end_with?('/')
          # Strip the beginning and trailing '/'
          query.gsub!(/^\//, '').gsub!(/\/$/, '')
          self.where(:url => Regexp.new(query)).desc(:timestamp).limit(count)
        else # It's a nick search.
          self.where(:nick => query).desc(:timestamp).limit(count)
        end
      end

    end
  end
end
