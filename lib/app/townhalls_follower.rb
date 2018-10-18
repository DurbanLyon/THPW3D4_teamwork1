require 'twitter'
require 'dotenv'
require 'json'
Dotenv.load

class TownHallsFollower

  # va chercher les noms des mairies dans le JSON
  def initialize()
    json = File.read("db/emails.json")
    @jsonparsed = JSON.parse(json)
  end

  # fonction qui cherche des handles avec les noms de mairie
  def get_handle()

    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_API_KEY"]
    config.consumer_secret     = ENV["TWITTER_API_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    @user_list = []
    p @jsonparsed
=begin
    @jsonparsed.each do |key, value|

        unless client.user_search("ville de #{key}").take(1) == nil
          @user_list << client.user_search("ville de #{key}").take(1)
        end
=end
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
end
