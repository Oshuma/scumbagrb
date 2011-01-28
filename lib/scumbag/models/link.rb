module Scumbag
  module Models

    class Link
      include Mongoid::Document

      field :url,       :type => String
      field :nick,      :type => String
      field :timestamp, :type => Time
    end

  end
end
