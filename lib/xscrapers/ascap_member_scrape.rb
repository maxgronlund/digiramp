require './lib/scrapers/scraper'
require './app/classes/daisy_chain.rb'
require './app/classes/table_strip.rb'
require './app/classes/all_except.rb'

class Scraper::AscapMemberScrape
  require_relative 'ascap_member_scrape/digiramp_browser'
  require_relative 'ascap_member_scrape/work_tbody_parser'
  require_relative 'ascap_member_scrape/work_detail_tbody_parser'
  require_relative 'ascap_member_scrape/ascap_member_login'
  require_relative 'ascap_member_scrape/ascap_work_collector'
  require_relative 'ascap_member_scrape/import'
  
  attr_reader :works, :works_details
  
  def self.exceptions; @@exceptions ||= [] end
  
  def initialize username, password
    @url = "https://members.ascap.com/"
    @ascap_member_login = AscapMemberLogin.new(username, password)
  end
  
  def start &block
    @block = block
    
    inform next_stage: :open_website              ;open_website                ;inform stage_complete: :open_website
    inform next_stage: :login                     ;login                       ;inform stage_complete: :login
    inform next_stage: :goto_works_from_dashboard ;goto_works_from_dashboard   ;inform stage_complete: :goto_works_from_dashboard
    #inform next_stage: :get_works                 ;get_works                   ;inform stage_complete: :get_works
    inform next_stage: :get_work_details          ;get_work_details            ;inform stage_complete: :get_work_details
    inform next_stage: :close_browser             ;close_browser               ;inform stage_complete: :close_browser
    #inform next_stage: :parse_works               ;parse_works                 ;inform stage_complete: :parse_works
    #inform next_stage: :parse_work_details        ;parse_work_details          ;inform stage_complete: :parse_work_details
    
    @done = true
    
  #rescue Exception => exception
  #  @exception = exception
  ensure
    close_browser
    #@exception and raise @exception
  end
  
  def done?;    !!@done     end
  def stopped?; !!@stopped  end
  
private

  def inform info
    @block.call(info) if @block
  end

  def open_website
    @browser = DigirampBrowser.new @url
  end
  
  def login
    @ascap_member_login.execute @browser
  end
  
  def goto_works_from_dashboard
    @browser.img(:id, 'btn_view_accepted_works').parent.click
  end
  
  def get_works
    work_collector.get_works
    inform total_works: work_collector.html_work_tbodies.length
  end
  
  def get_work_details
    work_collector.get_work_details @block
    inform total_work_details: work_collector.html_work_detail_tbodies.length
  end
  
  def parse_works
    @works = []
    @work_collector.html_work_tbodies.each do |html_work_tbody|
      work = WorkTbodyParser.new(html_work_tbody).parse
      inform parsed_work: work
      @works += work
    end
    @works
  end
  
  def parse_work_details
    @works_details = []
    @work_collector.html_work_detail_tbodies.each do |html_work_detail_tbody|
      work_details = WorkDetailTbodyParser.new(html_work_detail_tbody).parse
      inform parsed_work_details: work_details
      @works_details << work_details
    end
    @works_details
  end
  
  def work_collector
    @work_collector ||= AscapWorkCollector.new(@browser)
  end
  
  def close_browser
    @browser.close if @browser
    @browser = nil
  end
  
  def print_results
    puts @works
    puts "\n\n\n------Details:------------\n\n"
    puts @works_details
  end
end