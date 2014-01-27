#Example usage:
#  ipi = AscapIpi[full_name: 'RAFELSON PETER CARR']
#  ipi.works.each do |work|
#    puts work #class type AscapIswc
#  end

#require './contains_nothing'
#require './https_response'
require_relative 'ascap_ipi/parser'
require_relative 'ascap_ipi/request'
require_relative 'ascap_iswc'

class Scraper::AscapScraper::Ipi
  delegate :ipi_number,
           :party_name,
           :party_id,
           :party_type_code,
           :society,
  to: :parsed_data
  
  def initialize options
    @request_result = Scraper::AscapScraper::Ipi::Request[options] 
    @parsed_data = Scraper::AscapScraper::Ipi::Parser[@request_result.writers_search_data["result"].first] if @request_result.writers_search_data["result"] if @request_result.writers_search_data if @request_result
  end
  
  def works
    return @works || scrape_all_works
  end
  
  def work_ids
    if @request_result.works_search_data["result"]
      @request_result.works_search_data["result"].collect {|work| work['workId'] }.uniq
    else
      []
    end
  end
  
  def parsed_data?
    !!@parsed_data
  end
    
  class << self
    def []*args
      instance = new *args
      return instance
    end
  end
  
  #def scrape_all_works &block
  #  @works = []
  #  return @works unless @request_result.works_search_data["result"]
  #  work_ids = @request_result.works_search_data["result"].collect {|work| work['workId'] }.uniq
  #  
  #  work_ids.each do |work_id|
  #    work = AscapIswc[work_id: work_id]
  #    @works << work
  #    yield work if block_given?
  #  end
  #  
  #  @works
  #end
end