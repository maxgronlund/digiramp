require_relative 'writer_search'
require_relative 'writer_search_parser'

class Scraper::BmiScraper::WriterWorks
  attr_reader :works
  
  def display_message message
    puts message
    sleep 1
  end
  
  def get_url url
    Scraper::BmiScraper::WriterSearch.get_url url
  end
  
  def get_url url
    @writer_search = Scraper::BmiScraper::WriterSearch.new
    @writer_search.get_url url
    display_message "BmiWriterSearch in progress..." while @writer_search.in_progress
    @writer_search_parser = Scraper::BmiScraper::BmiWriterSearchParser.new @writer_search
    display_message "BmiWriterSearchParser in progress..." while @writer_search_parser.in_progress
    @writer_search_parser.get_works
    display_message "BmiWriterSearchParser getting works..." while @writer_search_parser.in_progress
    @works = @writer_search_parser.works
  end
  
  def self.[] name
    instance = new
    instance.get_url name
  end
end