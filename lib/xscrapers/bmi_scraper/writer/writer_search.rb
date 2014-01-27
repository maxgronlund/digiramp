require_relative 'writer_request'
require_relative 'writer_form_bot'

class Scraper::BmiScraper::WriterSearch
  attr_reader :in_progress, :results, :thread
  
  def get name
    return false if @thread
    
    @in_progress = true
    @thread = Thread.new do
      @writer_form_bot = writer_form_bot name
      @results = {@writer_form_bot.page_type => @writer_form_bot.page}
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  def get_url url
    return false if @thread
    
    @in_progress = true
    @thread = Thread.new do
      @writer_request = writer_request url
      @results = {@writer_request.page_type => @writer_request.page}
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  def in_progress
    @in_progress && @thread.alive?
  end

  def writer_form_bot name
    writer_form_bot = Scraper::BmiScraper::WriterFormBot.new name
    writer_form_bot.start
    writer_form_bot
  end
  
  def writer_request url
    writer_request = Scraper::BmiScraper::WriterRequest.new url
    writer_request.start
    writer_request
  end
end