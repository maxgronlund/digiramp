require_relative 'datatable'
require './lib/scrapers/scraper'

class AscapSearchWritersDatatable < Datatable
  
  Columns = %w[ascap_search_writer_results.party_id
               ascap_search_writer_results.party_name
               ascap_search_writer_results.party_type_code
               ascap_search_writer_results.ipi_code
               ascap_search_writer_results.society]
  
  def as_json(options = {})
    ascap_search_writer_results
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: 5,
      iTotalDisplayRecords: @total_count,
      aaData: data
    }
  end

  private
  
  def data
    @data ||= ascap_search_writer_results.map { |result|
      [h(result[:party_id]),
      h(result[:party_name]),
      h(result[:party_type_code]),
      h(result[:ipi_code]),
      h(result[:society])]
    }
  end
  
  def ascap_search_writer_results
    @ascap_search_writer_results ||= fetch_ascap_search_writer_results
  end
  
  
  def ascap_search_writer_results
    return @ascap_search_writer_results if @ascap_search_writer_results
    order = "#{sort_column} #{sort_direction}"
    ascap_search_writer_results = ascap_search_writer.ascap_search_writer_results.order(order)
    @total_count = ascap_search_writer_results.size
    ascap_search_writer_results = ascap_search_writer_results.page(page).per(per_page)
    @ascap_search_writer_results = ascap_search_writer_results
  end
  
  def ascap_search_writer
    return @ascap_search_writer if @ascap_search_writer
    @search_string = params["sSearch"].to_s.strip.downcase
    search_query = URI.escape(@search_string)
    ascap_search_writer = AscapSearchWriter.find_by_search_query(search_query)
    ascap_search_writer ||= scrape_ascap_search_writer(search_query)
    @ascap_search_writer = ascap_search_writer
  end
  
  def scrape_ascap_search_writer search_query
    ascap_search_writer = AscapSearchWriter.create(search_query: search_query)
    
    search_results = Scraper::AscapScraper::Search.writers_by_name search_query
    search_results = search_results.group_by { |result| result['partyId'] }
    search_results.each do |party_id, results|
      results.uniq! {|result|result['ipiNaNum']}
    end
    
    search_results.each do |id, party_account|
      party_account.each do |ipi|
        ipi_code = ipi['ipiNaNum'] == '0' ? '' : ipi['ipiNaNum']
        options = {
          party_id: ipi['partyId'],
          party_name: ipi['partyName'],
          party_type_code: ipi['partyTypeCde'],
          ipi_code: ipi_code,
          society: ipi['societyAcronym']
        }
        ascap_search_writer.ascap_search_writer_results.create(options)
        #@results <<  [h(ipi['partyId']), h(ipi['partyName']), h(ipi['partyTypeCde']), h(ipi_code), h(ipi['societyAcronym'])]
      end
    end
    
    
    #@search_results
    
    ascap_search_writer
  end
end