require 'gmail'
require 'dotenv/load'

class Mailer
    def initialize()
        @id = ENV['ID']
        @pass = ENV['PASS']
        
        json = File.read(ENV['JSON'])
        content = JSON.parse(json)
    end

    def mailer()
        gmail = Gmail.connect(ENV['ID'], ENV['PASS'])
        gmail.deliver do
            to "krashbook@gmail.com"
            subject "Hello World"
            text_part do
                body "ISSOU"
            end
        end
        gmail.logout
    end
end

mailer()