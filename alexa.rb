
require 'open-uri'
require 'nokogiri'
require 'csv'

CSV.open("alexa-ind-500.csv", "w") do |f|

  (0..19).each do |n|
    url = "http://www.alexa.com/topsites/countries;#{n}/IN"
    doc = Nokogiri::HTML(open(url))
    doc.css('li.site-listing h2 a').each do |link|
      f << [link.text]
    end
  end
end
