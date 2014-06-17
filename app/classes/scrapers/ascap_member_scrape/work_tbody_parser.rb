#require 'nokogiri'

## The data structure returned by parsing the work table element:
## works = [
##   {
##     title: String
##     work_id: String
##     registration_status: String
##     interested_parties: [
##       {
##         name: String
##         role: String
##         society: String
##         own_percent: String
##         collect_percent: String
##       }
##     ]
##   }
## ]



class Scraper::AscapMemberScrape::WorkTbodyParser
  require_relative 'work_tbody_ipi_parser'
  
  def initialize html_work_tbody
    @html_work_tbody = html_work_tbody
    @nokogiri_tbody = Nokogiri::HTML(@html_work_tbody)
  end
  
  def parse
    @works = []
    
    rows.each do |row|
      work = {}
      work[:title]                =   extract_title               row
      work[:ascap_work_id]        =   extract_work_id             row
      work[:ipis]                 =   extract_interested_parties  row
      work[:registration_status]  =   extract_registration_status row
      @works << work
    end
    
    @works
  end
  
  def pretty_display
    @works.each do |work|
      puts "\n\n#### Work Title: #{work[:title]} ####"
      puts "  Work ID: #{work[:work_id]}"
      puts "  Registration status: #{work[:registration_status]}"
      puts "  IPIS:"
      work[:interested_parties].each do |interested_party|
        puts "    ## IPI Name: #{interested_party[:name]}"
        interested_party.each do |k, v|
          puts "      #{k}: #{v}"
        end
      end
    end
  end
  

private

  
  def rows
    @nokogiri_tbody.xpath('/html/body/tbody/tr').to_a.all_except_first
  end

  def extract_title               row; row.xpath('.//tbody//span').first.text.to_s.table_strip     rescue '' end
  def extract_work_id             row; row.xpath('./td')[1].text.to_s.table_strip                  rescue '' end
  def extract_registration_status row; row.xpath('./td')[3].xpath('.//span').text.to_s.table_strip rescue '' end
  def extract_interested_parties  row; Scraper::AscapMemberScrape::WorkTbodyIpiParser.new(row).parse                                     end
end