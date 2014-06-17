class Scraper::AscapMemberScrape::WorkTbodyIpiParser
  def initialize work_table_row
    @work_table_row = work_table_row
  end
  
  def parse
    ipis = []
    
    rows.each do |row|
      ipi = {}
      ipi[:name]             =  extract_name            row
      ipi[:role]             =  extract_role            row
      ipi[:society]          =  extract_society         row
      ipi[:own_percent]      =  extract_own_percent     row
      ipi[:collect_percent]  =  extract_collect_percent row
      ipis << ipi
    end
    
    ipis
  end
  

private
  
  def rows
    ipi_table = @work_table_row.xpath('./td')[2]
    ipi_table.xpath('./table/tbody/tr')
  rescue; []
  end
  
  def extract_name            row;  row.xpath('.//td')[0].text.to_s.table_strip rescue '' end 
  def extract_role            row;  row.xpath('.//td')[1].text.to_s.table_strip rescue '' end
  def extract_society         row;  row.xpath('.//td')[2].text.to_s.table_strip rescue '' end
  def extract_own_percent     row;  row.xpath('.//td')[3].text.to_s.table_strip rescue '' end
  def extract_collect_percent row;  row.xpath('.//td')[4].text.to_s.table_strip rescue '' end
  
  
end