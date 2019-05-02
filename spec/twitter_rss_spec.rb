require 'rss'

# mock
class DummyResponse
  attr_reader :body
  def initialize(path)
    @body = open(File.join(__dir__, path)).read
  end
end

# mock
module TwitterAPI
  class Client
    def statuses_user_timeline(params)
      DummyResponse.new('data/statuses_user_timeline.json')
    end
  end
end

RSpec.describe TwitterRSS do

  it 'has a version number' do
    expect(TwitterRSS::VERSION).not_to be nil
  end

  it 'create a instance' do
    tr = TwitterRSS.new({
      :consumer_key => 'YOUR_CONSUMER_KEY',
      :consumer_secret => 'YOUR_CONSUMER_SECRET',
      :token => 'YOUR_ACCESS_TOKEN',
      :token_secret => 'YOUR_ACCESS_SECRET'
    })
    expect(tr).not_to be nil
  end

  it 'user_timeline' do
    tr = TwitterRSS.new({
      :consumer_key => 'YOUR_CONSUMER_KEY',
      :consumer_secret => 'YOUR_CONSUMER_SECRET',
      :token => 'YOUR_ACCESS_TOKEN',
      :token_secret => 'YOUR_ACCESS_SECRET'
    })
    rss = tr.user_timeline({
      'screen_name' => 'YOUR_SCREEN_NAME',
      'count' => '20',
      'tweet_mode' => 'extended'
    },{
      'channel' => {
        'title' => 'Your RSS feed title',
        'description' => 'Your RSS feed title',
        'link' => 'https://twitter.com/YOUR_SCREEN_NAME'
      },
    })
    expect(rss).not_to be nil

    rssobj = RSS::Parser.parse(rss)
    item = rssobj.items[0]
    expect(item.title).to eq '@niwasawa: test: more than 140 characters. test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,xyz'
    expect(item.link).to eq 'https://twitter.com/niwasawa/status/1123219219397529601'
    expect(item.description).to eq '@niwasawa: test: more than 140 characters. test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,xyz'
  end
end

