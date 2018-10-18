require 'nokogiri'
require 'open-uri'
require 'json'

class Scrapp_mairie

    attr_accessor :doc
    def initialize
        doc = doc
    end

    def get_the_email_of_a_townhal_from_its_webpage(url)
        doc = Nokogiri::HTML(open(url))
        doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |element| return element.text end
    end
        
    def get_all_the_urls_townhalls_page1(name)
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}.html"))
        doc2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}-2.html"))
        urlend = []
        tabname = []
        doc.css('.lientxt').each do |i| tabname << i.content end
        doc.css('a.lientxt @href').each do |i| urlend << i.content end
        doc2.css('.lientxt').each do |i| tabname << i.content end
        doc2.css('a.lientxt @href').each do |i| urlend << i.content end
        i = 0
        while i < urlend.size
           urlend[i][0] = ''
           urlend[i] = get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com#{urlend[i]}")
            i += 1
        end
        return p @myhash = Hash[tabname.zip(urlend)]
    end

    def get_all_the_urls_townhalls_many_pages(name)
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}.html"))
        doc2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}-2.html"))
        doc3 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}-3.html"))
        doc4 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{name}-4.html"))
        urlend = []
        tabname = []
        doc.css('.lientxt').each do |i| tabname << i.content end
        doc.css('a.lientxt @href').each do |i| urlend << i.content end
        doc2.css('.lientxt').each do |i| tabname << i.content end
        doc2.css('a.lientxt @href').each do |i| urlend << i.content endcote_d_or
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
               p urlend[i] = "Page not found"
               i += 1
            ensure
            end
        end 
       return @myhash = Hash[tabname.zip(urlend)]
    end

    def contents_to_json
        return File.open("db/emails_cote_d_or.JSON","w") do |f|
            f.write(get_all_the_urls_townhalls_many_pages(("cote-d-or")).to_json)
        end
    end
end