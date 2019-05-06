require 'twitter_rss/version'

require 'twitter_api'
require 'json'
require 'rss'

# Twitter RSS
class TwitterRSS

  # Initializes a TwitterRSS object.
  #
  # @param credentials [Hash] Credentials
  # @return [TwitterRSS]
  def initialize(credentials)
    @t = TwitterAPI::Client.new(credentials)
  end

  # Returns a RSS feed of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
  #
  # @param params [Hash] Parameters for Twitter API (GET statuses/user_timeline) {https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline}
  # @param info [Hash] RSS feed information
  # @return [String] RSS
  def user_timeline(params, info)
    json = @t.statuses_user_timeline(params).body
    tweets = JSON.parse(json)
    make_rss(info, tweets)
  end

  # Returns a RSS feed of the most recent Tweets liked by the authenticating or specified user.
  #
  # @param params [Hash] Parameters for Twitter API (GET favorites/list) {https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-favorites-list}
  # @param info [Hash] RSS feed information
  # @return [String] RSS
  def favorites(params, info)
    json = @t.favorites_list(params).body
    tweets = JSON.parse(json)
    make_rss(info, tweets)
  end

  # Returns a RSS feed of a collection of relevant Tweets matching a specified query.
  #
  # @param params [Hash] Parameters for Twitter API (Standard search API) {https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets}
  # @param info [Hash] RSS feed information
  # @return [String] RSS
  def search(params, info)
    json = @t.search_tweets(params).body
    searched = JSON.parse(json)
    tweets = searched['statuses']
    make_rss(info, tweets)
  end
 
  def make_rss(info, tweets)

    rss = RSS::Maker.make('2.0') do |maker|

      maker.channel.title = info['channel']['title']
      maker.channel.description = info['channel']['description']
      maker.channel.link = info['channel']['link']
  
      # Sort in new order
      maker.items.do_sort = true
  
      tweets.each do |f|

        # Use full_text for more than 140 characters.
        #
        # ref. Tweet updates — Twitter Developers
        # https://developer.twitter.com/en/docs/tweets/tweet-updates.html
        if f['retweeted_status']
          text = f['retweeted_status']['full_text'] ? f['retweeted_status']['full_text'] : f['retweeted_status']['text']
          screen_name = f['retweeted_status']['user']['screen_name']
          text = "RT @#{screen_name}: #{text}"
        else
          text = f['full_text'] ? f['full_text'] : f['text']
        end

        maker.items.new_item do |item|
          url = "https://twitter.com/#{f['user']['screen_name']}/status/#{f['id_str']}"
          item.link        = url
          item.title       = "@#{f['user']['screen_name']}: \"#{text}\" / Twitter"
          item.description = "#{text}"
          item.pubDate     = f['created_at']
        end
      end
    end
  
    rss.to_s
  end

end

