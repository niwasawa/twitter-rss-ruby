lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twitter_rss/version'

Gem::Specification.new do |spec|
  spec.name          = "twitter_rss"
  spec.version       = TwitterRSS::VERSION
  spec.authors       = ["Naoki Iwasawa"]
  spec.email         = ["niwasawa@maigo.info"]

  spec.summary       = 'Twitter RSS feed Ruby library'
  spec.description   = 'Twitter RSS feed Ruby library'
  spec.homepage      = 'https://github.com/niwasawa/twitter-rss-ruby'
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'twitter_api', '~> 0.1.9'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

