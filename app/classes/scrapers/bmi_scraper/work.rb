require_relative 'terms_and_conditions'

class Scraper::BmiScraper::Work
  include Scraper::BmiScraper::TermsAndConditions
  
  def display_message message
    puts message
    sleep 1
  end
  
  def get_url url, only_by_this_publisher_url=""
    @only_by_this_publisher_url = only_by_this_publisher_url
    @agent = Mechanize.new
    @page = @agent.get url
    accept_terms_and_conditions
    tables = []
    @page.search('table').each do |table|
      tables << {table: table, class: table.attribute("class")}
    end
    @info_table = tables.find {|table| table[:class] == nil}
    @info_table = @info_table[:table] if @info_table
    
    @work_number = @page.search('td[class="work_number"]').first
    @work_number = @work_number.text if @work_number
    
    @title = @page.search('td[class="work_title"]').first
    @title = @title.text.gsub("(Legal Title)", '').strip if @title
    
    if @info_table
      info_tables = []
      header_names = []
      info_table = nil
      @info_table.search("tr").each do |tr|
        headers = tr.search('th')
        header_change = false
        headers.each_with_index do |header_name, index|
          header_names[index] = header_name.text
          header_change = true
        end
        if header_change
          info_table = []
          info_tables << info_table
        else
          info_table ||= []
        end
        
        cells = tr.search('td')
        row = {}
        cells.each_with_index do |cell, index|
          row[header_names[index] || index] = cell
        end
        
        unless row.empty? or (row.values.select {|cell| not cell.text.match(/\w|\d/i)}.length == row.length)
          info_table << row
        end
      end
      
      @raw_info_table = {writers: [], publishers: []}
      info_tables.each do |table|
        if table.find {|row| row["Songwriter/Composer"]}
          @raw_info_table[:writers] = table
        elsif table.find {|row| row["Publishers"]}
          @raw_info_table[:publishers] = table
        end
      end
      
      @info_table = {writers: [], publishers: [], bmi_work_number: @work_number.delete("BMI Work #").strip, title: @title}
      @raw_info_table[:writers].each do |writer|
        name, url = writer["Songwriter/Composer"].text, $bmi_repertoire+writer["Songwriter/Composer"].search('a').attribute('href').to_s
        society = writer["Current Affiliation"].text
        ipi_code =  writer["CAE/IPI #"].text
        @info_table[:writers] << {name: name, url: url, society: society, ipi_code: ipi_code}
      end

      @raw_info_table[:publishers].each do |publisher|
        url = publisher["Publishers"].search('a').first
        name = publisher["Publishers"].text
        url = url.attribute('href').to_s if url
        society = publisher["Current Affiliation"].text
        ipi_code =  publisher["CAE/IPI #"].text
        @info_table[:publishers] << {name: name, url: url.to_s, society: society, ipi_code: ipi_code}
      end
      puts "<>----------------------------------------<>"
      
      
      @only_by_this_publisher_keyid = @only_by_this_publisher_url.match(/(?<=keyid=)\d+/i).to_s
      
      if @only_by_this_publisher_url.to_s.contains_nothing?
        return @info_table
      else
        @info_table[:publishers].each do |publisher|
          return @info_table if @only_by_this_publisher_keyid == publisher[:url].match(/(?<=keyid=)\d+/i).to_s
        end
        puts "\n\n\n"
        return nil
      end
      
    end
  end
  
  def self.[] *args
    instance = new
    instance.get_url *args
  end
end