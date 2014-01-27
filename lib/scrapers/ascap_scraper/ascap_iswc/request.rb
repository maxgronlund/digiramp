require 'json'

class Scraper::AscapScraper::Iswc
  class Request
    attr_reader :iswc_code,
                :iswc_url,
                :iswc_data,
                :work_url,
                :raw_data
    
    def self.[] options
      instance = new options
      return instance if instance.data_valid?
      return nil
    end
    
    def initialize options
      @work_id = options[:work_id] || scrape_work_id(options[:iswc_code])
      scrape_work_data @work_id if @work_id
    end
    
    def data_valid?
      (@work_url.kind_of? String and not @work_url.strip.empty?) &&
      (@raw_data.kind_of? Hash and not @raw_data.empty?)
    end
    
    
    private
    
    
    def scrape_work_data work_id
      @work_url = "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/works?workId=#{work_id}"
      @raw_data = JSON.parse(HttpsResponse.get(@work_url).body)["result"].first
    end
    
    def scrape_work_id iswc_code
      @iswc_code = iswc_code
      @iswc_url = "https://mobile.ascap.com/wservice/MobileWeb/service/ace/api/v0.1/works?limit=100&page=1&iswc=#{@iswc_code}"
      @iswc_data = JSON.parse HttpsResponse.get(@iswc_url).body
      @work_id = @iswc_data["result"].first["workId"] if @iswc_data["result"]
    end
  end # Request
end # AscapIswc


# USAGE
# if scrape = ASCAP::ISWCScrape["T0702726508"]
#   puts scrape.iswc_data
#   puts scrape.raw_data
#   puts scrape.interested_parties
# else
#   puts "Scrape unsuccessful."
# end

#testing
# puts ASCAP::ISWCScrape["T0702726508"].raw_data["result"]
#ASCAP::ISWCScrape["T0702726508"].raw_data["result"].first["interestedParties"].each do |ip|
#  puts ip
#  puts "\n\n"
#end