$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'cinch'

module Scumbag
  VERSION = '0.0.1'

  autoload :Links, 'scumbag/links'
end
