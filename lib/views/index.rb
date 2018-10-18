$:.unshift File.expand_path("./../../app", __FILE__) # emplacement des apps à lancer

require 'townhalls_mailer'
require 'townhalls_follower'
require 'townhalls_scrapper'


class Index

  def initialize
    puts "Bonjour, bienvenu dans notre application"
    puts "Que voulez-vous faire ?"
    main_options
  end

  def main_options

    puts "1. Récupérer les noms et adresses emails des mairies"
    puts "2. Envoyer un mail publicitaire à une adresse mail choisi"
    puts "3. Envoyer un mail publicitaire à chaque mairie"
    puts "4. Follow les mairies sur twitter"
    puts "5. Effacer les données en database"
    puts "6. Quitter l'application"

    # Check si l'utilisateur rentre une commande valide
    possible_choices = ["1", "2", "3", "4", "5", "6"]
    choice = ""
    until possible_choices.include?(choice)
      choice = gets.chomp.to_s
      unless possible_choices.include?(choice) then puts "Merci de rentrer une commande valide." end
    end

    # Commandes
    if choice == "1" # Crée un fichier JSON en db et scrapp les données des mairies
      Scrapp_mairie.new.create
      unless FileTest.exist?("db/emails.json") then puts "Erreur : le fichier n'a pas été créé en database" end # Verif si le fichier JSON a bien été créé en db
      puts "Données récupérées, voulez-vous les afficher ? y/n"
      if gets.chomp == "y" then puts File.open("db/emails.json") end


    elsif choice == "2" # Envoi un mail à une adresse rentrée par l'utilisateur
      puts "A quelle adresse email faut-il envoyer le mail publicitaire ?"
      Mailer.new.test_mail_sending()


    elsif choice == "3" # Envoi un mail publicitaire à chaque mairie
      unless FileTest.exist?("db/emails.json") then puts "Veuillez récupérer les emails des mairies d'abord" end # Verif si le fichier JSON a bien été créé en db
      Mailer.new.spammer()


    elsif choice == "4" # Follow les mairies sur twitter
      unless FileTest.exist?("db/emails.json") then puts "Veuillez récupérer les emails des mairies d'abord" end# Verif si le fichier JSON a bien été créé en db
      TownHallsFollower.new


    elsif choice == "5" # Efface le fichier JSON
      File.delete("db/emails.json")
      if FileTest.exist?("db/emails.json") then puts "Je n'ai pas réussi à effacer les données..."
      else puts "Données effacées !"
      end


    elsif choice == "6" # Quitte l'appli
      return puts "A bientôt !"
    end

    # Renvoi au menu
    puts "\n Autre chose ?"
    main_options

  end # main_options

end # Index
