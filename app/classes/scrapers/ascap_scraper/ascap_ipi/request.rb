require 'uri'
require 'json'

class Scraper::AscapScraper::Ipi
  class Request
    attr_reader :ipi_number,
                :party_id,
                :works_search_url,
                :works_search_data,
                :writers_search_url,
                :writers_search_data
                
    
    def self.[] options
      instance = new options
      return instance if instance.ipis_search_data_valid? || instance.works_search_data_valid?
      return nil
    end
    
    def initialize options
      @party_id = options[:party_id] || scrape_party_id_using_full_name( options[:full_name], options[:scrape_type] )
      case options[:scrape_type].to_s
      when 'writer'; @works_search_url = "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/writer/works?partyId=#{@party_id}&limit=10000"
      #when 'publisher'; @works_search_url = "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/writer/works?partyId=#{@party_id}&limit=10000"
      when 'performer'; @works_search_url = "https:// mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/performer/works?partyId=#{@party_id}&limit=10000"
      end
      response = HttpsResponse.get(@works_search_url).body
      warn "\n\n\n-------------------------------\n#{response}\n\n#{@works_search_url}\n#{options}\n-----"
      @works_search_data = JSON.parse response
    end
    
    def scrape_party_id_using_full_name full_name, scrape_type
      if full_name.kind_of? String
        full_name = URI.escape full_name
        
        case scrape_type.to_s
        when writer
          @ipis_search_url = "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/writers?fullName=#{full_name}"
          @ipis_search_data = JSON.parse HttpsResponse.get(@writers_search_url).body
        when publisher
          @ipis_search_url = "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/publishers?fullName=#{full_name}"
          @ipis_search_data = JSON.parse HttpsResponse.get(@publishers_search_url).body
        end
        
        #!! using the first search result here, maybe the first isn't the correct one
        @party_id = @ipis_search_data["result"].first['partyId'] if @ipis_search_data["result"]
      else
        raise ArgumentError, "Options must contain either :full_name or :party_id as a string"
      end
      
      @party_id
    end
    
    def ipis_search_data_valid?
      (@ipis_search_url.kind_of? String and not @ipis_search_url.strip.empty?) &&
      (@ipis_search_data.kind_of? Hash and not @ipis_search_data.empty?)
    end
    
    def works_search_data_valid?
      (@works_search_url.kind_of? String and not @works_search_url.strip.empty?) &&
      (@works_search_data.kind_of? Hash and not @works_search_data.empty?)
    end
   
  end # Request
end # AscapIpi