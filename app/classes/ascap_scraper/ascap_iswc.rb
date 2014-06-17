#require './contains_nothing'
#require './https_response'
require_relative 'ascap_iswc/parser'
require_relative 'ascap_iswc/request'
require_relative 'ascap_iswc/interested_parties'

class Scraper::AscapScraper::Iswc
  attr_reader :parsed_data
  delegate :work_title,
           :work_title_type_code,
           :alternative_titles,
           :rank,
           :work_id,
           :dispute_flag,
           :special_payment_indicator,
           :iswc_code,
           :interested_parties,
           :performers,
  to: :parsed_data
  
  def initialize options
    @request_result ||= Scraper::AscapScraper::Iswc::Request[work_id: options[:work_id]] if options[:work_id]
    @request_result ||= Scraper::AscapScraper::Iswc::Request[iswc_code: options[:iswc_code]] if options[:iswc_code]
    @parsed_data = Scraper::AscapScraper::Iswc::Parser[@request_result.raw_data] if @request_result
  end
  
  def parsed_data?
    !!@parsed_data
  end
    
  class << self
    def [] options
      instance = new(options)
      return instance if instance.parsed_data?
      return nil
    end
  end
end