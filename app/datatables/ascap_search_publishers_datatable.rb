require_relative 'datatable'
require './lib/scrapers/scraper'

class AscapSearchPublishersDatatable < Datatable
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: data.length,
      iTotalDisplayRecords: data.length,
      aaData: data
    }
  end

  private
  
  def data
    return @results if @results
    @results = []
    
    unless params[:sSearch].to_s.contains_nothing?
      @search_string = params[:sSearch]
      @search_results = Scraper::AscapScraper::Search.publishers_by_name(URI.escape @search_string)
      @search_results.each do |search_result|
        email = search_result["email"].first["email"] rescue ""
        phone = search_result["phone"].first["phoneNumber"] rescue ""
        country = search_result["address"].first["countryDesc"] rescue ""
        city = search_result["address"].first["city"] rescue ""
        @results << [h(search_result['partyId']), 
                     h(search_result['partyName']),
                     h(search_result['ipiNaNum']),
                     h(search_result['societyAcronym']),
                     h(country.to_s),
                     h(city.to_s),
                     h(email.to_s),
                     h(phone.to_s)]
      end
    end
    
    @results
  end
end