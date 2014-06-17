require_relative 'writer/writer_works'
require_relative 'work'
require_relative 'publisher/publisher_request'

class Scraper::BmiScraper::Import < GenericWorkImport
  include Celluloid
  attr_reader :errors
  
  @@import_class = -> {CommonWorksImport}
  
  def do_scrape    
    @works = []
    Rails.logger.info @params.inspect
    @params["bmi_party_urls"].uniq.each do |bmi_party_url|
      #find_or_create_ipi party_url
      @works.push *Scraper::BmiScraper::WriterWorks[bmi_party_url]
    end
    
    @scrape.update total_works: @works.length, processed_works: 0, imported_works: 0, updated_works: 0
    
    @works.each do |work|
      bmi_work = Scraper::BmiScraper::Work[work[:url], @params["only_by_this_publisher_url"].to_s]
      create_work bmi_work if bmi_work
      @scrape.processed_works += 1
      ##@scrape.save # !!! could be removed for optimization
      scrape_update_notification
    end
  end
  
  
  private
  
  
  def create_work bmi_work_data
    bmi_work_data = bmi_work_data.first if bmi_work_data.kind_of? Array
    return unless bmi_work_data
    begin
      common_work = find_or_create_common_work(bmi_work_data)
      bmi_work_data[:writers].each do |writer|
        import_ipi = @account.import_ipis.find_or_create_by_bmi_party_url \
          full_name: writer[:name].to_s,
          bmi_party_url: writer[:url].to_s,
          ipi_code: writer[:ipi_code].to_s,
          scrape_type: 'writer',
          society: writer[:society].to_s
          
        common_work.ipis.create \
          import_ipi_id: import_ipi.id,
          full_name: writer[:name].to_s
      end
      bmi_work_data[:publishers].each do |publisher|
        import_ipi = @account.import_ipis.find_or_create_by_bmi_party_url \
          full_name: publisher[:name].to_s,
          bmi_party_url: publisher[:url].to_s,
          ipi_code: publisher[:ipi_code].to_s,
          scrape_type: 'publisher',
          society: publisher[:society].to_s
        common_work.ipis.create \
          import_ipi_id: import_ipi.id,
          full_name: publisher[:name].to_s
      end
    rescue StandardError => error
      @errors[:work_creation_error] << error
    end
  end
  
  def find_or_create_common_work bmi_work_data
    c = CommonWork.where(bmi_work_number: bmi_work_data[:bmi_work_number], account_id: @scrape.account_id).first
    if c
      @scrape.updated_works += 1
      c.bmi_scrape_id = @scrape.id
      return c
    else
      @scrape.imported_works += 1
      c = @scrape.common_works.create \
        bmi_work_number: bmi_work_data[:bmi_work_number],
        title: bmi_work_data[:title],
        bmi_work_url: bmi_work_data[:url],
        creation_type: 'bmi',
        account_id: @scrape.account_id
    end
  end
  
  def find_or_create_ipi bmi_party_url
    
    #scrape_options = { scrape_common_works: true, scrape_type: 'writer' }
    #unless @params["only_by_this_publisher"].to_s.contains_nothing? || @params["only_by_this_publisher_id"].to_s.contains_nothing?
    #  scrape_options[:scrape_only_by_this_publisher] = \
    #  "#{@params["only_by_this_publisher"]};#{@params["only_by_this_publisher_id"]}"
    #end
    #@ipi.update scrape_options
  end
end
