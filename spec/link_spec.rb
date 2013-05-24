require 'spec_helper'

describe Link do

  before(:each) do
    @attrs = {
      nick: "luser#{rand(100)}",
      url: "http://example.com/foo/#{rand(100)}"
    }
  end

  it 'has a nick' do
    Link.create(@attrs).nick.should == @attrs[:nick]
  end

  it 'has a url' do
    Link.create(@attrs).url.should == @attrs[:url]
  end

  it 'has a timestamp' do
    Link.create(@attrs).timestamp.should_not be_nil
  end

  it 'searches with regexp' do
    link = Link.create(@attrs.merge(url: 'http://example.org/'))
    Link.search('/org/').should == [link]
  end

  it 'searches by nick' do
    link = Link.create(@attrs.merge(nick: 'foo'))
    Link.search('foo').should == [link]
  end

end
