require 'nokogiri'
require 'open-uri'
require 'json'
require 'colorize'

class Scrapp_mairie

    attr_accessor :doc
    def initialize
        doc = doc
    end

    def get_the_email_of_a_townhal_from_its_webpage(url)
        doc = Nokogiri::HTML(open(url))
        doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |element| return element.text end
    end

    def get_all_the_urls_townhalls_cot_d_or
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/cote-d-or.html"))
        doc2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/cote-d-or-2.html"))
        doc3 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/cote-d-or-3.html"))
        doc4 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/cote-d-or-4.html"))
        urlend = []
        tabname = []
        doc.css('.lientxt').each do |i| tabname << i.content end
        doc.css('a.lientxt @href').each do |i| urlend << i.content end
        doc2.css('.lientxt').each do |i| tabname << i.content end
        doc2.css('a.lientxt @href').each do |i| urlend << i.content end
        doc3.css('.lientxt').each do |i| tabname << i.content end
        doc3.css('a.lientxt @href').each do |i| urlend << i.content end
        doc4.css('.lientxt').each do |i| tabname << i.content end
        doc4.css('a.lientxt @href').each do |i| urlend << i.content end
        i = 0
        while i < urlend.size
            begin
                urlend[i] = get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com#{urlend[i]}")
                i += 1
            rescue => exception
               p urlend[i] = ("L'url de la mairie de #{tabname[i]} est indisponible")
               i += 1
            ensure
            end
        end 
       return myhash = Hash[tabname.zip(urlend)]
    end

    def get_all_the_urls_townhalls_rhone
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/rhone.html"))
        doc2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/rhone-2.html"))
        urlend = []
        tabname = []
        doc.css('.lientxt').each do |i| tabname << i.content end
        doc.css('a.lientxt @href').each do |i| urlend << i.content end
        doc2.css('.lientxt').each do |i| tabname << i.content end
        doc2.css('a.lientxt @href').each do |i| urlend << i.content end
        i = 0
        while i < urlend.size
            begin
                urlend[i] = get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com#{urlend[i]}")
                i += 1
            rescue => exception
               p urlend[i] = ("L'url de la mairie de #{tabname[i]} est indisponible")
               i += 1
            ensure
            end
        end 
        return myhash = Hash[tabname.zip(urlend)]
    end

    def get_all_the_urls_townhalls
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/bouches-du-rhone.html"))
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
        return  myhash = Hash[tabname.zip(urlend)]
    end

    def create
        file = File.open("db/emails.json", "w")
        system "clear"
        puts "Création du tableau de hash pour le departement du Rhone...".green
        hash_lyon = get_all_the_urls_townhalls_rhone
        puts "Création du tableau de hash pour le departement du Cote d'or...".green
        hash_cote_d_or = get_all_the_urls_townhalls_cot_d_or
        puts "Création du tableau de hash pour le departement du Bouche du Rhone...".green
        hash_bouch_du_rhone = get_all_the_urls_townhalls
        puts "Fusion des tableaux de hash...".red
        hash = hash_lyon.merge(hash_cote_d_or)
        super_hash = hash.merge(get_all_the_urls_townhalls)
        puts "Création du fichier .json".green
        puts "FIN...".green
        return File.open("db/emails.json","w") do |f|
            f.write(super_hash.to_json)
        end
    end
end