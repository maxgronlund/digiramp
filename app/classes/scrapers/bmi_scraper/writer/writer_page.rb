class Scraper::BmiScraper::WriterPage
  attr_reader :columns
  
  def initialize page
    @page = page
    @columns = []
    collect_columns
  end
  
  
  def display_results
    @columns.each do |column|
      puts column
    end
    puts "A total of #{@columns.length} columns!"
  end
  
  def collect_columns
    collect_columns_from @page
    collect_columns_from_next_pages
  end
  
  private
  
  def collect_columns_from page
    page.search('table tr').each do |r|
      row = r.search('td')
      column = []
      row.each do |element|
        column << element
      end
      @columns << column  
    end
  end
  
  def collect_columns_from_next_pages
    current_page = @page
    300.times do
      link = current_page.link_with(text: "Next>")
      break unless link
      current_page = link.click
      collect_columns_from current_page
    end
  end
end

# @agent = Mechanize.new


