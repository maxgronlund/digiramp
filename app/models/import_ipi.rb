class ImportIpi < ActiveRecord::Base
  
  belongs_to :account
  has_one :ipi
  
  def create_common_works_from_ascap
    
  end
  
  def scrape_common_works_from_ascap &block
    ascap_ipi   = Scraper::AscapScraper::Ipi[ party_id: ascap_party_id, scrape_type: scrape_type ] unless ascap_party_id.contains_nothing?
    ascap_ipi ||= Scraper::AscapScraper::Ipi[ full_name: full_name,     scrape_type: scrape_type ] unless full_name.contains_nothing?
    return unless ascap_ipi
  
    ascap_ipi.scrape_all_works do |work|
      should_scrape = should_scrape? work
      yield work if should_scrape
    end
    
    self.scrape_common_works = false
    self.save
  end
  
  def work_ids
    ascap_ipi   = Scraper::AscapScraper::Ipi[party_id: ascap_party_id, scrape_type: scrape_type] unless ascap_party_id.contains_nothing?
    ascap_ipi ||= Scraper::AscapScraper::Ipi[full_name: full_name,     scrape_type: scrape_type] unless full_name.contains_nothing?    
    ascap_ipi ? ascap_ipi.work_ids : []
  end
  
  def should_scrape? work
    return false unless work
    should_scrape = false
  
    if work.parsed_data?   
      if self.scrape_only_by_this_publisher.contains_nothing? || self.scrape_only_by_this_publisher.to_s.strip == ";"
        should_scrape = true
      else
        work.parsed_data.interested_parties.each do |interested_party|
          should_scrape = is_publisher?(interested_party) &&
                          is_selected_publisher?(interested_party)
        end        
      end   
    else  
      Rails.logger.info "No parsed data for work!"
    end
  
    should_scrape
  end
  
  def is_selected_publisher? interested_party
    selected_name, selected_ascap_party_id = *self.scrape_only_by_this_publisher.to_s.upcase.strip.split(';') 
    (interested_party[:full_name].to_s.upcase.strip      == selected_name.to_s.upcase.strip) &&
    (interested_party[:ascap_party_id].to_s.upcase.strip == selected_ascap_party_id.to_s.upcase.strip)
  end
  
  def is_publisher? interested_party
    interested_party[:role_code].to_s.upcase.include? "P"
  end
end
