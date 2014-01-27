require 'mechanize'
require_relative '../terms_and_conditions'

class Scraper::BmiScraper::WriterRequest
  include Scraper::BmiScraper::TermsAndConditions
  attr_reader :page
  
  def initialize url
    @agent = Mechanize.new
    @url = url
  end
  
  def start
    get_page @url
    accept_terms_and_conditions
    #display_results
  end
  
  def get_page url
    @page = @agent.get url
  end
  
  def display_results
    puts "Search!\n" if writers_search_page?
    puts "Result!\n" if writer_result_page?
    p @page
  end
  
  def writers_search_page?
    @page.uri.to_s.downcase.include? "WriterSearch.asp".downcase
  end
  
  def writer_result_page?
    @page.uri.to_s.include? "writer.asp"
  end
  
  def page_type
    return :writer_list if writers_search_page?
    return :writer if writer_result_page?
    return :unknown
  end
end