require 'twitter'
require 'dotenv'
require 'json'
Dotenv.load

class TownHallsFollower

  def initialize()
    # On va chercher les noms des mairies dans le JSON
    json = File.read(ENV['JSON'])
    @jsonparsed = JSON.parse(json)
  end

    # Fonction qui cherche des handles avec les noms de mairie
  def get_handle()

    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_API_KEY"]
    config.consumer_secret     = ENV["TWITTER_API_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    @user_list = []
    @jsonparsed.each do |key, value|

        unless client.user_search("ville de #{key}").take(1) == nil
          @user_list << client.user_search("ville de #{key}").take(1)
        end

    end
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

  # Fonction qui enregistre nom|mail|handle dans un CSV
  def create_csv()

  end
end
