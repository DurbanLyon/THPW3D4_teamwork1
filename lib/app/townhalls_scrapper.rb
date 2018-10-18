require 'nokogiri'
require 'open-uri'
require 'json'
    
    class Scrapper
    
       attr_accessor :doc
       def initialize
           doc = doc
       end
    
       def get_the_email_of_a_townhal_from_its_webpage(url)
           doc = Nokogiri::HTML(open(url))
           doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |element| return element.text end
       end
    
       def get_all_the_urls_townhalls(name)
           doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}.html"))
           urlend = []
           tabname = []
           doc.css('.lientxt').each do |i| tabname << i.content end
           doc.css('a.lientxt @href').each do |i| urlend << i.content end
           i = 0
           while i < urlend.size
              urlend[i][0] = ''
              urlend[i] = get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com#{urlend[i]}")
               i += 1
           end
           return p @myhash = Hash[tabname.zip(urlend)]
       end
    
       def contents_to_jsone
           return File.open("db/Emails_var.JSON","w") do |f|
               f.write(get_all_the_urls_townhalls('var').to_json)
           end
       end

       def contents_to_json
        return File.open("db/Emails_bouchedurhone.JSON","w") do |f|
            f.write(get_all_the_urls_townhalls('bouches-du-rhone').to_json)
        end
    end
end
