require_relative 'writer_search'
require_relative 'writer_search_parser'

class Scraper::BmiScraper::WriterList
  def display_message message
    puts message
    sleep 1
  end
  
  def get name
    @writer_search = Scraper::BmiScraper::WriterSearch.new
    @writer_search.get name
    display_message "BmiWriterSearch in progress..." while @writer_search.in_progress
    @writer_search_parser = Scraper::BmiScraper::WriterSearchParser.new @writer_search
    display_message "BmiWriterSearchParser in progress..." while @writer_search_parser.in_progress
    @writer_search_parser.writers
  end
  
  def self.[] name
    instance = new
    instance.get name
  end
end