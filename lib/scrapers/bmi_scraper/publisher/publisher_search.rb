require_relative 'publisher_request'
require_relative 'publisher_form_bot'

class Scraper::BmiScraper::PublisherSearch
  attr_reader :in_progress, :results, :thread
  
  def get name
    return false if @thread
    
    @in_progress = true
    @thread = Thread.new do
      @bmi_publisher_form_bot = bmi_publisher_form_bot name
      @results = {@bmi_publisher_form_bot.page_type => @bmi_publisher_form_bot.page}
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  def get_url url
    return false if @thread
    
    @in_progress = true
    @thread = Thread.new do
      @bmi_publisher_request = bmi_publisher_request url
      @results = {@bmi_publisher_request.page_type => @bmi_publisher_request.page}
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  def in_progress
    @in_progress && @thread.alive?
  end

  def bmi_publisher_form_bot name
    bmi_publisher_form_bot = Scraper::BmiScraper::PublisherFormBot.new name
    bmi_publisher_form_bot.start
    bmi_publisher_form_bot
  end
  
  def bmi_publisher_request url
    bmi_publisher_request = Scraper::BmiScraper::PublisherRequest.new url
    bmi_publisher_request.start
    bmi_publisher_request
  end
end