require_relative 'publisher_search'
require_relative 'publisher_search_parser'

class Scraper::BmiScraper::PublisherList
  def display_message message
    puts message
    sleep 1
  end
  
  def get name
    @bmi_publisher_search = Scraper::BmiScraper::PublisherSearch.new
    @bmi_publisher_search.get name
    display_message "BmiPublisherSearch in progress..." while @bmi_publisher_search.in_progress
    @bmi_publisher_search_parser = Scraper::BmiScraper::PublisherSearchParser.new @bmi_publisher_search
    display_message "BmiPublisherSearchParser in progress..." while @bmi_publisher_search_parser.in_progress
    @bmi_publisher_search_parser.publishers
  end
  
  def self.[] name
    instance = new
    instance.get name
  end
end