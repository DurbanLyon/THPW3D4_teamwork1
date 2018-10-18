require 'gmail'
require 'json'

# encoding: utf-8

class Mailer
    def initialize()
    end

    def spammer()
        json = File.read('db/emails.json')
        hash = JSON.parse(json)

        gmail = Gmail.connect(ENV['ID'], ENV['PASS'])
        hash.each do | key, value |
            gmail.deliver do
                to value
                subject 'THE HACKING PROJECT'
                html_part do
                    content_type 'text/html; charset=UTF-8'
                    body "Bonjour,<br>Nous sommes élèves à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.<br><br>Déjà 500 personnes sont passées par The Hacking Project. Est-ce que votre mairie veut changer le monde avec nous ?<br><br><strong>Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions</strong> : 06.95.46.60.80"
                end
            end
            puts "Mail was sent to #{value}"
        end
        puts 'All mail was sent'
        puts 'Gmail will logout'
        gmail.logout
        puts 'Done'
    end

    def test_mail_sending()
            hash = { "MAIL" => "#{gets.chomp}" }
            puts "Ecris un nombre"
            number = gets.chomp.to_i
            gmail = Gmail.connect(ENV['ID'], ENV['PASS'])
            i = 1
            while i <= number
                hash.each do | key, value |
                    gmail.deliver do
                        to value
                        subject "TEST" + "#{i}"
                        html_part do
                            content_type 'text/html; charset=UTF-8'
                            body "JE SUIS UN TEST :)"
                        end
                    end
                    puts "Mail was sent to #{value}"
                end
                i += 1
            end
        puts 'All mail was sent'
        puts 'Gmail will logout'
        gmail.logout
        puts 'Done'
    end
end
