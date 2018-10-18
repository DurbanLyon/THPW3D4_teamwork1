require 'twitter'
require 'dotenv'
Dotenv.load

@user_list = []


# fonction qui va chercher les noms des mairies dans le JSON
def get_town_name()

end


# fonction qui cherche des handles avec les noms de mairie
def get_handle(array)

  client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

  @user_list = []
  @user_list << client.user_search('villeurbanne').take(1)
  return @user_list
end

# Fonction qui follow les mairies
def follow_all(array)
   client = Twitter::REST::Client.new do |config|
   config.consumer_key        = ENV["TWITTER_API_KEY"]
   config.consumer_secret     = ENV["TWITTER_API_SECRET"]
   config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
   config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
   end

   array.each{|elem| client.follow(elem)}
end

get_handle(@user_list)
follow_all(@user_list)

puts @user_list
