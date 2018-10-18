$:.unshift File.expand_path("./../../app", __FILE__)
$:.unshift File.expand_path("./../../app/mailer", __FILE__)
#require 'townhalls_mailer'
#require 'townhalls_follower'
#require 'townhalls_scrapper'

$db_json = "./../../db/Emails.JSON"

class Index

  def initialize
    puts "Bonjour, bienvenu dans notre application"
    main_options
  end

  def main_options

    puts "Que voulez-vous faire ?"
    puts "1. Récupérer les noms et adresses emails des mairies"
    puts "2. Envoyer un mail publicitaire à chaque mairie"
    puts "3. Follow les mairies sur twitter"
    puts "4. Effacer les données en database"
    puts "5. Quitter l'application"

    # Check si l'utilisateur rentre une commande valide
    possible_choices = ["1", "2", "3", "4", "5"]
    choice = ""
    until possible_choices.include?(choice)
      choice = gets.chomp.to_s
      unless possible_choices.include?(choice) then puts "Merci de rentrer une commande valide." end
    end

    # Commandes
    if choice == "1"

      Scrapper.new # Scrapp les données des mairies et crée un JSON en db
      unless FileTest.exist?($db_json) then puts "Erreur : le fichier n'a pas été créé en database" end # Verif si le fichier JSON a bien été créé en db
      puts "Données récupérées, voulez-vous les afficher ? y/n"
      if gets.chomp = "y" then puts File.open($db_json) end


    elsif choice == "2"
      unless FileTest.exist?($db_json) then puts "Veuillez récupérer les emails des mairies d'abord" end# Verif si le fichier JSON a bien été créé en db

    elsif choice == "3"
      unless FileTest.exist?($db_json) then puts "Veuillez récupérer les emails des mairies d'abord" end# Verif si le fichier JSON a bien été créé en db

    elsif choice == "4"

    elsif choice == "5"
      return puts "A bientôt !"
    end

  end # main_options

end # Index
