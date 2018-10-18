require 'twitter'
require 'dotenv'
Dotenv.load

@user_list = []



def publish(string)
  client = Twitter::REST::Client.new do |config|
   config.consumer_key        = ENV["TWITTER_API_KEY"]
   config.consumer_secret     = ENV["TWITTER_API_SECRET"]
   config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
   config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

  client.update(string)
end
