## The stucture of the work details is
## { ipis: [{:name, :role, :ipi_number, :society, :own_percent, :collect_percent, :has_agreement, :linked_to_ascap_member, :controlled_by_submitter}],
##   title: String,
##   ascap_work_id: String,
##   alternate_ids: {"ISWC"=>String, "Submitter Work ID"=>String ...},
##   details: {"Genre" => String, "Intended Purpose" => String ...}
## }

class Scraper::AscapMemberScrape::WorkDetailTbodyParser
  attr_reader :work_name, :ascap_work_id, :ipis
  
  def initialize html_work_detail_tbody
    @share_tbody = html_work_detail_tbody[:share_list]
    @other_tbody = html_work_detail_tbody[:other]
    @details_tbody = html_work_detail_tbody[:details]
    @nokogiri_share_tbody = Nokogiri::HTML(@share_tbody)
    @nokogiri_other_tbody = Nokogiri::HTML(@other_tbody)
    @nokogiri_details_tbody = Nokogiri::HTML(@details_tbody)
  end
  
  def parse
    parse_work
    parse_ipis
    parse_details
    parse_other
    return {ipis: @ipis, title: @work_title, ascap_work_id: @ascap_work_id, alternate_ids: @alternate_ids, details: @details}
  end
  
  def parse_work
    @ascap_work_id = work_info_table[0].xpath('./span')[1].inner_html
    @work_title = work_info_table[1].xpath('./span')[1].inner_html
  end
  
  def parse_ipis
    @ipis = []
    
    ipi_rows.each do |row|
      ipi = {}
      ipi[:full_name] = row.xpath('./td//span')[0].inner_html.table_strip
      ipi[:role] = row.xpath('./td//span')[1].inner_html.table_strip
      ipi[:ipi_number] = row.xpath('./td')[1].xpath('.//span').inner_html.table_strip
      ipi[:society] = row.xpath('./td')[2].xpath('.//span').inner_html.table_strip
      ipi[:own_percent] = row.xpath('./td')[4].xpath('.//td').inner_html.table_strip
      ipi[:collect_percent] = row.xpath('./td')[5].xpath('.//td').inner_html.table_strip
      ipi[:has_agreement] = row.xpath('./td')[6].xpath('.//span').inner_html.table_strip == "Y"

      status = row.xpath('./td')[3].xpath('.//span').inner_html.table_strip
      ipi[:linked_to_ascap_member]  = !status.match(/unidentified/i)
      ipi[:controlled_by_submitter] = !status.include?("Non-Authoritative")
      
      @ipis << ipi
    end
    
    @ipis
  end
  
  def parse_details    
    @details = {}
    
    @nokogiri_details_tbody.xpath("/html/body/tbody/tr/td")[0].xpath('./table/tbody/tr/td/table')[1].xpath('./tbody/tr').each do |tr|
      spans = tr.xpath('.//span')
      key = spans[0].inner_html.gsub(/\<.*\>/, '').table_strip
      value = spans[1].inner_html.table_strip
      @details[key] = value
    end
    
    @details
  end
  
  def parse_other
    @alternate_ids = {}

    tds = @nokogiri_other_tbody.xpath('/html/body/tbody/tr').first.xpath('./td')
    alternate_id_trs = tds[2].xpath('./table/tbody/tr/td/table')[1].xpath('./tbody/tr').to_a.all_except_first
    alternate_id_trs.each do |alternate_id_tr|
      tds = alternate_id_tr.xpath('./td')
      id = tds[0].xpath('./span').inner_html.table_strip
      type = tds[1].xpath('./span').inner_html.table_strip
      @alternate_ids[type] = id
    end
    
    @alternate_ids
  end
  
private

  def work_info_table
    @work_info_table ||= @nokogiri_share_tbody.xpath('/html/body/tbody/tr')[0].xpath('.//table//table/tbody/tr/td')
  end

  def ipi_rows
    @ipi_rows ||= ipi_table.xpath('./td/table/tbody/tr/td/table/tbody/tr').to_a.all_except_first
  end
  
  def ipi_table
    @ipi_table ||= @nokogiri_share_tbody.xpath('/html/body/tbody/tr')[1]
  end
end