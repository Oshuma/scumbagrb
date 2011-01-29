module Scumbag
  module Models

    class Link
      include Mongoid::Document

      # Use the 'links' collection instead of namespaced name.
      store_in :links

      field :url,       :type => String
      field :nick,      :type => String
      field :timestamp, :type => Time
    end

  end
end
