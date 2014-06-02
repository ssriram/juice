
require 'open-uri'
require 'nokogiri'
require 'csv'

url = "http://www.startupranking.com/top-100/india"
suburl = "http://www.startupranking.com"

CSV.open("startups.csv", "w") do |f|

  doc = Nokogiri::HTML(open(url))
  
  doc.css('div.well td.left a').each do |link|
    surl = suburl+link['href']
    subdoc = Nokogiri::HTML(open(surl))
    l = subdoc.css('div.dash-unit a')
    link_url = l[0]['href']
    link_desc = subdoc.css('div.container-body #description_content')
    link_desc = link_desc.text

    f << [link.text, link_url, link_desc]
  end
end
