# TwitterRSS: Twitter RSS feed Ruby library

[![Gem Version](https://badge.fury.io/rb/twitter_rss.svg)](https://badge.fury.io/rb/twitter_rss)

This library is under development and unstable.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twitter_rss'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twitter_rss

## Usage

```ruby
require 'twitter_rss'

# create a instance of TwitterRSS
tr = TwitterRSS.new({
  :consumer_key => 'YOUR_CONSUMER_KEY',
  :consumer_secret => 'YOUR_CONSUMER_SECRET',
  :token => 'YOUR_ACCESS_TOKEN',
  :token_secret => 'YOUR_ACCESS_SECRET'
})

# get RSS feed (GET statuses/user_timeline)
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
puts rss

# get RSS feed (GET favorites/list)
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
puts rss

# get RSS feed (Standard search API)
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
puts rss
```

## Documentation

- Documentation for twitter_rss https://www.rubydoc.info/gems/twitter_rss/
- GET statuses/user_timeline — Twitter Developers https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline
- GET favorites/list — Twitter Developers https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-favorites-list
- Standard search API — Twitter Developers https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets
- Tweet updates — Twitter Developers https://developer.twitter.com/en/docs/tweets/tweet-updates.html
  - more than 140 characters, tweet_mode=extended, full_text

## Development

```
$ rake -T
rake build            # Build twitter_rss-X.X.X.gem into the pkg directory
rake clean            # Remove any temporary products
rake clobber          # Remove any generated files
rake install          # Build and install twitter_rss-X.X.X.gem into system gems
rake install:local    # Build and install twitter_rss-X.X.X.gem into system gems without network access
rake release[remote]  # Create tag vX.X.X and build and push twitter_rss-X.X.X.gem to Rubygems
rake spec             # Run RSpec code examples
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/niwasawa/twitter-rss-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

