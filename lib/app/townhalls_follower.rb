require 'twitter'
require 'dotenv'
require 'json'
require 'rubocop'
require 'google_drive'
require "open-uri"

Dotenv.load

# *************************************************************************** #
# ------------------       townhalls_follower.rb        --------------------- #
# *************************************************************************** #
# Definition de la CLASSE TownHallsFollower
#
# => Permet de recuperer les noms des mairies pour follow les handle de ces
#    mairies sur twitter.
#
# Methodes :
#  - initialize() : parse du fichier JSON et lance la methode perform()
#                   la methode initialize() suffit a tout lancer
#  - get_handle() : methode cherchant avec l'API twitter les handles de mairies
#  - follow_all() : methode qui follow les mairies sur twitter
#  - create_csv() : methode qui enregistre nom|mail|handle dans un CSV
#  - perform()    : lancement global
# *************************************************************************** #

# def class
class TownHallsFollower
  # methode initialisation
  def initialize
    perform()
  end

  # methode cherchant avec l'API twitter les handles de mairies
  def get_handle()
      # parse du fichier JSON

      json = File.read('db/emails.json') # adresse du fichier
      @jsonparsed = JSON.parse(json)

      client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_API_KEY']
      config.consumer_secret      = ENV['TWITTER_API_SECRET']
      config.access_token         = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret  = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end

    user_list = []
    @jsonparsed.each do |k, _v|
      unless client.user_search("ville de #{k}").take(1) == nil?
        user_list << client.user_search("ville de #{k}").take(1)
      end
      puts user_list
      return user_list
    #end
  end

  # methode qui follow les mairies sur twitter
  def follow_all(user_list)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_API_KEY']
      config.consumer_secret      = ENV['TWITTER_API_SECRET']
      config.access_token         = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret  = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    user_list.each do |elem|
      client.follow(elem)
      puts "Follow #{elem} done"
    end
  end

  # methode qui enregistre nom|mail|handle dans un CSV
  def create_spreadsheet
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1IhE2BwMGhfnGdoPjqBCL2L4z6c5ttrwNezllMuprUSQ").worksheets[0]
    file = File.read('/home/salim/THP/semaine03/day14/teamrocket/db/emails.json')
        my_hash = JSON.parse(file)
        i = 1
        my_hash.each do |key , value|
            ws[i, 1] = key
            ws[i, 2] = value
            ws[i, 3] = "@#{key}"
            i += 1
        end
        ws.save
  end

  # lancement global
  def perform
    user_list = get_handle()
    follow_all(user_list)
    #create_csv
  end
end