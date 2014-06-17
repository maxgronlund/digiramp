require 'mechanize'
require_relative '../terms_and_conditions'
require_relative '../writer/writer_request'
class Scraper::BmiScraper::PublisherRequest < Scraper::BmiScraper::WriterRequest
  include Scraper::BmiScraper::TermsAndConditions
  
  def display_results
    puts "Search!\n" if publishers_search_page?
    puts "Result!\n" if publisher_result_page?
    p @page
  end
  
  def publishers_search_page?
    @page.uri.to_s.downcase.include? "pubSearch.asp".downcase
  end
  
  def publisher_result_page?
    @page.uri.to_s.downcase.include? "publisher.asp"
  end
  
  def page_type
    return :publisher_list if publishers_search_page?
    return :publisher if publisher_result_page?
    return :unknown
  end
end