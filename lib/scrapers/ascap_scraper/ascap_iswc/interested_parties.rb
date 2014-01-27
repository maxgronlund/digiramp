class Scraper::AscapScraper::Iswc
  class InterestedParties
    attr_reader :interested_parties
  
    def initialize raw_data
      @raw_data = raw_data
      @interested_parties = []
      parse_interested_parties if @raw_data["interestedParties"]
    end
  
    def self.[] *args
      instance = new *args
      return instance.interested_parties
    end
    
    
    private
  
  
    def parse_interested_parties
      @raw_data["interestedParties"].each do |interested_party|
        ipi_hash = parse_interested_party_to_hash( interested_party )
        @interested_parties << ipi_hash if ipi_hash
      end
      @interested_parties
    end
  
    
    def parse_interested_party_to_hash interested_party
      ipi_code = interested_party["ipiNaNum"].to_s.strip
      return nil if ipi_code.contains_nothing? or ipi_code == "0"
    
      interested_party_hash = {
        ipi_code: ipi_code,
        society: interested_party["societyName"].to_s,
        role_code: interested_party["roleCde"].to_s.strip,
        email: "",
        phone_number: "",
        full_name: interested_party['fullName'],
        ascap_party_id: interested_party['partyId'],
        address_1: "",
        address_2: "",
        city: "",
        country: "",
        country_code: "",
        postal_code: "",
        province: "",
        state: "",
        state_code: "",
        name_2: "",
        name_3: ""
      }
     
      interested_party_hash[:email] =        interested_party["email"].first["email"].to_s if interested_party["email"] 
      interested_party_hash[:phone_number] = interested_party["phone"].first["phoneNumber"].to_s if interested_party["phone"]
    
      if interested_party["address"]
        address = interested_party["address"].first
        interested_party_hash.merge! \
          address_1:    address["line1"].to_s,
          address_2:    address["line2"].to_s,
          city:         address["city"].to_s,
          country:      address["countryDesc"].to_s,
          country_code: address["countryCde"].to_s,
          postal_code:  address["postalCde"].to_s,
          province:     address["province"].to_s,
          state:        address["stateDesc"],
          state_code:   address["stateCde"],
          name_2:       address["name2"].to_s,
          name_3:       address["name3"].to_s
      end
          
      interested_party_hash
    end
  end
end