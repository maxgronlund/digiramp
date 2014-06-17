require_relative 'scraper'
username = '4sepublishing'
password = 'ascapascap'
scrape = Scraper::AscapMemberScrape.new username, password

require 'pp'
scrape.start do |info|
  pp info
  puts "\n--------------------------------\n"
end
puts "\n\n"
puts "Results: \n"
pp scrape.works_details
