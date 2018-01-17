require 'dotenv'
Dotenv.load

require 'twitter'

client2 = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_API_KEY']
  config.consumer_secret     = ENV['TWITTER_API_SECRET']
  config.access_token        = ENV['TWITTER_TOKEN']
  config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
end

p client2

# Bot qui va streamer tous les tweets qui mentionnent tea, ou coffee

topics = ["coffee", "tea"]
client2.filter(track: topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
end

