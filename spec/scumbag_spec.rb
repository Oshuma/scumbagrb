require 'spec_helper'

describe Scumbag do
  it 'has a version' do
    Scumbag::VERSION.should_not be_nil
  end

  it 'has a setup!() method' do
    Scumbag.should respond_to(:setup!)
    Scumbag.should_receive(:configure_database).once
    Scumbag.setup!(SPEC_CONFIG_FILE)
  end

  it 'has a create_bot() method' do
    mock_bot = mock('bot')
    ::Cinch::Bot.should_receive(:new).and_return(mock_bot)
    Scumbag.should_receive(:setup!).with(SPEC_CONFIG_FILE).once
    Scumbag.create_bot(SPEC_CONFIG_FILE).should == mock_bot
  end

  it 'has some options' do
    Scumbag.options.should == ::YAML.load_file(SPEC_CONFIG_FILE)
  end
end
