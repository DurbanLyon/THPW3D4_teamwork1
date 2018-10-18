$:.unshift File.expand_path("./../../app", __FILE__)
require 'townhalls_mailer'
require 'townhalls_adder_to_db'
require 'townhalls_follower'
require 'townhalls_scrapper'

class Index

  def initialize
    puts "Bonjour, bienvenu dans notre application"
    main_options
  end

  def main_options

    puts "Que voulez-vous faire ?"
    puts "1. Récupérer les adresses emails des mairies"
    puts "2. Envoyer un mail publicitaire à chaque mairie"
    puts "3. Follow les mairies sur twitter"
    puts "4. Quitter l'application"

    # Check si l'utilisateur rentre une commande valide
    possible_choices = ["1", "2", "3", "4"]
    choice = ""
    until possible_choices.include?(choice)
      choice = get.chomp.to_s
      unless possible_choices.include?(choice) then puts "Merci de rentrer une commande valide."
    end

    # Commandes
    if choice == "1"

    elsif choice == "2"

    elsif choice == "3"

    elsif choice == "4"
      return puts "A bientôt !"
    end
