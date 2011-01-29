require "#{File.dirname(__FILE__)}/../lib/scumbag"
require 'rspec'

SPEC_CONFIG_FILE = "#{File.dirname(__FILE__)}/scumbag.spec.yml"

Rspec.configure do |config|
  config.mock_with :rspec

  Scumbag.setup!(SPEC_CONFIG_FILE)

  # Drop all collections after specs are run.
  config.after :suite do
    Mongoid.master.collections.select do |collection|
      collection.name !~ /system/
    end.each(&:drop)
  end
end
