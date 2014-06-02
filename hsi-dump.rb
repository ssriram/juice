

require 'open-uri'
require 'nokogiri'
require 'csv'

site = "http://hackerstreet.in"
url = "http://hackerstreet.in"

posts = []
users = []

CSV.open("hsi-dump.csv","w") do |f|
  begin
    doc = Nokogiri::HTML(open(url))

    doc.css('td.title a').each do |link|
      l = link['href']
      if link['href'].start_with?("item?id")
        l = site+'/'+l
      end
      posts << [link.text, l] unless link.text == 'More'
      if link.text == 'More'
        url = site+link['href']
      else
        url = ""
      end
    end

    doc.css('td.subtext a').each do |user|
      users << user.text if user['href'].start_with?("user?id")
    end

    posts.zip(users).each do |p, u|
      f << [p[0], p[1], u]
    end

    posts = []
    users = []

    puts url
  end until url == ""
end
