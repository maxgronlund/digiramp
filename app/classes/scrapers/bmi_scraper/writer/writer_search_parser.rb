require_relative 'writer_page'
$bmi_repertoire = "http://repertoire.bmi.com/"
class Scraper::BmiScraper::WriterSearchParser
  attr_reader :writers, :works
  
  def initialize writer_search
    @writer_search = writer_search
    parse
  end
  
  def parse
    @in_progress = true
    @thread = Thread.new do
      if @writer_search.results[:writer_list]
        @page = @writer_search.results[:writer_list]
        parse_writer_list
      elsif @writer_search.results[:writer]
        @page = @writer_search.results[:writer]
        parse_writer
      end
      @in_progress = false
    end
    @thread.abort_on_exception = true
  end
  
  def in_progress
    @in_progress && @thread.alive?
  end
  
  def get_works
    raise "Can't get works from list of writers" if @page == @writer_search.results[:writer_list]
    @in_progress = true
    @works = []
    @thread = Thread.new do
      Scraper::BmiScraper::WriterPage.new(@page).columns.each do |column|
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
  
  def parse_writer_list
    @writers = []
    
    Scraper::BmiScraper::WriterPage.new(@page).columns.each do |column|
      result_index, name, ipi_code, society = *column
      if name
        if link = name.search('a').first
          name = link
          url = $bmi_repertoire + link.attribute('href').to_s
        else
          warn "WHAT TO DO WITH THIS NAME? #{name.inspect}"
        end
        @writers << {name: name.text, ipi_code: ipi_code.text, society: society.text, url: url}
      end
    end
  end
  
  def parse_writer
    
    @name = ""
    @page.search('h1').each do |h1|
      type, @name = h1.text.split(':')
      @name.strip!
    end
    
    @society, @ipi_code = @page.search("#affiliation").text.split('CAE/IPI #:')
    @society = @society.to_s.strip.delete('Current Affiliation:')
    @ipi_code = @ipi_code.to_s.strip
    url = @page.uri.to_s
    
    @writers = [{name: @name, society: @society, ipi_code: @ipi_code, url: url}]
  end
  
end