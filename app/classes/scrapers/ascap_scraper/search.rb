require 'json'

module Scraper::AscapScraper::Search
  class << self
    def writers_by_name name
      search "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/writers?fullName=#{name}"
    end
    
    def publishers_by_name name
      # NB can't be used to get Musical Works info from ascap's system
      search "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/publishers?fullName=#{name}"
    end
    
    def performers_by_name name
      search "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/performers?fullName=#{name}"
    end
    
    def search url
      search_data = JSON.parse HttpsResponse.get(url).body
      search_data["result"] || []
    end
  end
end