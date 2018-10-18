require 'twitter'
require 'dotenv'
Dotenv.load

@user_list = ['lyon', 'villeurbanne']


# fonction qui va chercher les noms des maireis dans le JSON
def get_town_name()
end


# fonction qui cherche
def
end

end


def follow_all(array)
   client = Twitter::REST::Client.new do |config|
   config.consumer_key        = ENV["TWITTER_API_KEY"]
   config.consumer_secret     = ENV["TWITTER_API_SECRET"]
   config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
   config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
   end

 array.each{|elem| client.follow(elem)}
end





follow_all(@user_list)
