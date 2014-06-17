require_relative 'ascap_iswc'

class Scraper::AscapScraper::Import < GenericWorkImport
  attr_reader :errors
  
  @@import_class = -> {CommonWorksImport}
  
  def do_import
    puts "\n\ndo_import\n\n"
    @work_ids = []
    @params["writers"].each do |writer|
      warn "Got ascap_party_id: #{writer[0]}"
      find_or_create_and_update_import_ipi writer[0]
      @work_ids.push *@import_ipi.work_ids
    end
    
    puts "@import.update"
    @import.update total_works: @work_ids.length, processed_works: 0, imported_works: 0, updated_works: 0
    
    @work_ids.each do |work_id|
      puts "work_id: #{work_id}, @import.id #{@import.id}"
      ascap_iswc = Scraper::AscapScraper::Iswc[work_id: work_id]
      create_work ascap_iswc if ascap_iswc        
      @import.processed_works += 1
      @import.save # !!! could be removed for optimization
      import_update_notification
    end
  end
  
  
  private
  
  
  def create_work work_data
    common_work = CommonWork.where(title: work_data.work_title, ascap_work_id: work_data.work_id, account_id: @import.account_id).first
    puts "common_work: #{common_work}, work_id: #{work_data.work_id}"
    if common_work
      @import.updated_works += 1
      
    else
      @import.imported_works += 1
      common_work = @import.common_works.create \
        account_id: @import.account_id,
        ascap_work_id: work_data.work_id,
        alternative_titles: work_data.alternative_titles,
        iswc_code: work_data.iswc_code,
        title: work_data.work_title
                                      
      work_data.interested_parties.each do |interested_party|
        next if interested_party.contains_nothing?
        import_ipi = @account.import_ipis.find_or_create_by_ipi_code interested_party
        Ipi.create \
          import_ipi_id: import_ipi.id,
          common_work_id: common_work.id,
          full_name: import_ipi.full_name,
          email: import_ipi.email,
          phone_number: import_ipi.phone_number
      end
    end
    
    common_work
  end
  
  
  def find_or_create_and_update_import_ipi ascap_party_id
    @import_ipi = @account.import_ipis.find_or_create_by_ascap_party_id ascap_party_id: ascap_party_id
    scrape_options = { scrape_common_works: true, scrape_type: 'writer' }
    unless @params["publisher"].contains_nothing? or @params["publisher"][0].contains_nothing?
      scrape_options[:scrape_only_by_this_publisher] = \
      "#{@params["publisher"][1]};#{@params["publisher"][0]}"
    end
    @import_ipi.update scrape_options
  end
end