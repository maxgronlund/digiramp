class Scraper::AscapScraper::Iswc
  class Parser
    attr_reader :work_title,
                :work_title_type_code,
                :alternative_titles,
                :rank,
                :work_id,
                :dispute_flag,
                :special_payment_indicator,
                :iswc_code,
                :performers,
                :interested_parties
    
    def self.[] *args
      instance = new *args
      instance
    end
  
    def initialize ascap_iswc_hash
      @raw_data = ascap_iswc_hash
    
      @work_title = @raw_data['workTitle']
      @work_title_type_code = @raw_data['workTitleTypeCde']
      @alternative_titles = @raw_data['alternateTitles']
      @rank = @raw_data['rank']
      @work_id = @raw_data['workId']
      @dispute_flag = @raw_data['disputeFlag']
      @special_payment_indicator = @raw_data['specialPaymentIndicator']
      @iswc_code = @raw_data['ISWCCde']
    
      @performers = []
      if @raw_data['performers'] 
        @raw_data['performers'].each do |performer|
          @performers << performer['fullName']
          #performer['resourceUri']
        end
      end
    
      @interested_parties = Scraper::AscapScraper::Iswc::InterestedParties[@raw_data]
    end
  end # Parser
end # AscapIswc