require 'twitter'
require 'dotenv'
require 'json'
Dotenv.load

<<<<<<< HEAD


#GET HANDLES
#session = GoogleDrive::Session.from_config("client_secret_416334651372-4a5qsimq97jp78ei0kjp39kmhgrjn8j0.apps.googleusercontent.com.json")
#ws = session.spreadsheet_by_key("LIEN DU SPREADSHEET").worksheets[0]
=begin
json = File.read(ENV['JSON'])
=======
@user_list = []


# fonction qui va chercher les noms des mairies dans le JSON
def get_town_name()

end
>>>>>>> origin

content = JSON.parse(json)

<<<<<<< HEAD


=end

#FOLLOW AND CONTACT
@town_hall_list = ["Lyon3", "Lyon4", "Villeurbanne"]





  def follow_all(array)
     client = Twitter::REST::Client.new do |config|
     config.consumer_key        = ENV["TWITTER_API_KEY"]
     config.consumer_secret     = ENV["TWITTER_API_SECRET"]
     config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
     config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
   end #end do

   array.each{|elem| client.follow(elem)}

 end #end def



 def contact(string,array)
=======
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
>>>>>>> origin
   client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_API_KEY"]
    config.consumer_secret     = ENV["TWITTER_API_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
   end

<<<<<<< HEAD
   array.each{|elem| client.update("@" + elem + " " + string) }
 end


  def research(array)

    client = Twitter::REST::Client.new do |config|
    config.consumer_key =  ENV["TWITTER_API_KEY"]
    config.consumer_secret = ENV["TWITTER_API_SECRET"]
    config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    array.each do |name|
      begin #quesako ?
        @twitter = Twitter.user_search(name)
        if @twitter
          if twitter_user = @twitter.first
            puts "#{twitter_user[:name]}: #{twitter_user[:screen_name]}"

            # Save your data here, write it to a database or something.
          end
        end
=begin
      rescue Twitter::Unauthorized
        puts "Not authorized. Please check the Twitter credentials at the top of the script."
        break

      rescue Twitter::BadRequest => e
        puts "Hit rate limit. Continuing scraping at #{e.ratelimit_reset}"
        sleep e.retry_after
        retry

      rescue Exception => e
        puts "Something else went wrong:"
        puts e.message
=end
      end
    end
  end


research(@town_hall_list)
=======
   array.each{|elem| client.follow(elem)}
end

get_handle(@user_list)
follow_all(@user_list)

puts @user_list
>>>>>>> origin
