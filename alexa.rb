
require 'sequel'
require 'open-uri'
require 'nokogiri'
require 'csv'

FILENAME = "alexa-ind-500.db"

#SELECTOR = "li.site-listing h2 a"
SELECTOR = ".desc-paragraph a"


def pull_data

  Sequel.sqlite(FILENAME) do |db|
    id = 1
    day = Time.now

    (0..20).each do |n|
      url = "http://www.alexa.com/topsites/countries;#{n}/IN"
      doc = Nokogiri::HTML(open(url))
      db.transaction do  
        doc.css(SELECTOR).each do |link|
          puts "#{link.text.downcase}, #{id}, #{day}"
          db[:links].insert(:id => id, :link => link.text.downcase, :entry_dt => day)
          id += 1
        end
      end
    end

  end

end


pull_data


