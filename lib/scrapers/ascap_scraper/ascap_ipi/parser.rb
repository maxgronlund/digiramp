class Scraper::AscapScraper::Ipi
  class Parser
    attr_reader :ipi_number,
                :party_name,
                :party_id,
                :party_type_code,
                :society
    def self.[] *args
      instance = new *args
      instance
    end
  
    def initialize ascap_ipi_hash
      @ipi_number = ascap_ipi_hash["ipiNaNum"]
      @party_name = ascap_ipi_hash["partyName"]
      @party_id = ascap_ipi_hash["partyId"]
      @party_type_code = ascap_ipi_hash["partyTypeCde"]
      @society = ascap_ipi_hash["societyAcronym"]
      #ascap_ipi_hash["resourceUri"]
      #ascap_ipi_hash["exceptionFlag"]
    end
  end
end