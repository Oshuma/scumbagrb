require "#{File.dirname(__FILE__)}/../lib/scumbag"
require 'rspec'

SPEC_CONFIG_FILE = "#{File.dirname(__FILE__)}/scumbag.spec.yml"

RSpec.configure do |config|
  include Scumbag::Models

  config.mock_with :rspec

  config.before :suite do
    Scumbag.setup!(SPEC_CONFIG_FILE)

    # Re-create the database and run migrations.
    database = ActiveRecord::Base.connection_config[:database]
    File.delete(database) if File.exists?(database)
    Scumbag.run_migrations!
  end
end
