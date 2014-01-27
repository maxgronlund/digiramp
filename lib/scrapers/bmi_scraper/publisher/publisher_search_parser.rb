require_relative 'publisher_page'

$bmi_repertoire = "http://repertoire.bmi.com/"

class Scraper::BmiScraper::BmiPublisherSearchParser
  attr_reader :publishers, :works
  
  def initialize bmi_publisher_search
    @bmi_publisher_search = bmi_publisher_search
    parse
  end
  
  def parse
    @in_progress = true
    @thread = Thread.new do
      if @bmi_publisher_search.results[:publisher_list]
        @page = @bmi_publisher_search.results[:publisher_list]
        parse_publisher_list
      elsif @bmi_publisher_search.results[:publisher]
        @page = @bmi_publisher_search.results[:publisher]
        parse_publisher
      end
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  def in_progress
    @in_progress && @thread.alive?
  end
  
  def get_works
    raise "Can't get works from list of publishers" if @page == @bmi_publisher_search.results[:publisher_list]
    @in_progress = true
    @works = []
    @thread = Thread.new do
      Scraper::BmiScraper::PublisherPage.new(@page).columns.each do |column|
        blank, result_index, title, iswc_code = *column
        if title
          url = $bmi_repertoire + title.search('a').attribute('href').to_s
          title = title.text 
        end
        iswc_code = iswc_code.text if iswc_code
        @works << {title: title.to_s.strip, iswc_code: iswc_code.to_s.strip, url: url.to_s} if title || iswc_code
      end
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  private
  
  def parse_publisher_list
    @publishers = []
    
    Scraper::BmiScraper::PublisherPage.new(@page).columns.each do |column|
      result_index, name, ipi_code, society = *column
      if name
        if link = name.search('a').first
          name = link
          url = $bmi_repertoire + link.attribute('href').to_s
        else
          puts "WHAT TO DO WITH THIS NAME?"
        end
        @publishers << {name: name.text, ipi_code: ipi_code.text, society: society.text, url: url}
      end
    end
  end
  
  def parse_publisher
    
    @name = ""
    @page.search('h1').each do |h1|
      @name = h1.text.to_s.strip
    end
    
    @society, @ipi_code = @page.search("#cae_ipi").text.split('CAE/IPI #:')
    @society = @society.to_s.strip.delete('Current Affiliation:')
    @ipi_code = @ipi_code.to_s.strip
    url = @page.uri.to_s
    
    @publishers = [{name: @name, society: @society, ipi_code: @ipi_code, url: url}]
  end
  
end