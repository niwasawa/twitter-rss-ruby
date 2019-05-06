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
    def favorites_list(params)
      DummyResponse.new('data/favorites_list.json')
    end
    def search_tweets(params)
      DummyResponse.new('data/search_tweets.json')
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
    expect(item.title).to eq '@niwasawa: "test: more than 140 characters. test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,xyz" / Twitter'
    expect(item.link).to eq 'https://twitter.com/niwasawa/status/1123219219397529601'
    expect(item.description).to eq 'test: more than 140 characters. test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,test,xyz'
  end

  it 'favorites' do
    tr = TwitterRSS.new({
      :consumer_key => 'YOUR_CONSUMER_KEY',
      :consumer_secret => 'YOUR_CONSUMER_SECRET',
      :token => 'YOUR_ACCESS_TOKEN',
      :token_secret => 'YOUR_ACCESS_SECRET'
    })
    rss = tr.favorites({
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
    expect(item.title).to eq '@maigolab_test: "TEST: more than 140 characters. TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,ZZZ" / Twitter'
    expect(item.link).to eq 'https://twitter.com/maigolab_test/status/1123825480799531010'
    expect(item.description).to eq 'TEST: more than 140 characters. TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,ZZZ'
  end

  it 'search' do
    tr = TwitterRSS.new({
      :consumer_key => 'YOUR_CONSUMER_KEY',
      :consumer_secret => 'YOUR_CONSUMER_SECRET',
      :token => 'YOUR_ACCESS_TOKEN',
      :token_secret => 'YOUR_ACCESS_SECRET'
    })
    rss = tr.search({
      'q' => 'SEARCH_QUERY',
      'count' => '20',
      'tweet_mode' => 'extended'
    },{
      'channel' => {
        'title' => 'Your RSS feed title',
        'description' => 'Your RSS feed title',
        'link' => 'https://twitter.com/search?q=SEARCH_QUERY'
      },
    })
    expect(rss).not_to be nil

    rssobj = RSS::Parser.parse(rss)
    item = rssobj.items[0]
    expect(item.title).to eq '@niwasawa: "search_test_maigolab: more than 140 characters. search test maigolab,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,ZZZZZZ" / Twitter'
    expect(item.link).to eq 'https://twitter.com/niwasawa/status/1124295153470955520'
    expect(item.description).to eq 'search_test_maigolab: more than 140 characters. search test maigolab,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,TEST,ZZZZZZ'
  end
end

