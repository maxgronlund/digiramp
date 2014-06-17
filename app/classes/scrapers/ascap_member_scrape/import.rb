class Scraper::AscapMemberScrape::Import < GenericWorkImport
  #def initialize html_work_tbody
  #  @html_work_tbody = html_work_tbody
  #  @nokogiri_tbody = Nokogiri::HTML(@html_work_tbody)
  #end
  @@import_class = -> {CommonWorksImport}
  
  def do_import
    scrape = Scraper::AscapMemberScrape.new(@params["username"], @params["password"])
    @import_ipis = []
    scrape.start do |info|
      info.each do |type, data|
        Rails.logger.debug "Scrape info. #{type}: #{data}"
        case type
        #when :next_stage; puts "#{data} being executed..."
        #when :stage_completed; puts "Finished executing: #{data}"
        #when :parsed_work
        when :parsed_work_details
          @import.processed_works += 1
          @import.save
        when :total_works, :total_work_details
          @import.update total_works: data if @import.total_works < data
        when :html_work_detail_tbodies
          parsed_data = Scraper::AscapMemberScrape::WorkDetailTbodyParser.new(data).parse
          @import.imported_works += 1 if create_work_from_details parsed_data
          @import.save!
          import_update_notification
        end
      end
    end
    
    #@import_ipis = []
    #scrape.works_details.each do |work_details|
    #  @import.imported_works += 1 if create_work_from_details work_details
    #  import_update_notification
    #end
    
    @import
    
    
    #@work_ids.each do |work_id|      
    #  @import.processed_works += 1
    #  @import.save # !!! could be removed for optimization
    #  import_update_notification
    #end
  end
  
private

  def create_work_from_details data
    #return if CommonWork.where account_id: @import.account_id, ascap_work_id: data[:ascap_work_id]
    common_work_data = {
      account_id: @import.account_id,
      ascap_work_id: data[:ascap_work_id],
      title: data[:title]#,alternative_titles: work_data.alternative_titles
    }
    
    common_work_data[:iswc_code] = data[:alternate_ids] && data[:alternate_ids]["ISWC"]
    common_work = @import.common_works.create common_work_data
      
                           
    data[:ipis].each do |interested_party|
      next if interested_party.contains_nothing?
      
      case interested_party[:role]
      when "Composer Writer";     role_code = "C"
      when "Composer/Author";     role_code = "CA"
      when "Original Publisher";  role_code = "E"
      when "Sub Publisher";       role_code = "SE"
      when "Administrator";       role_code = "AM"
      else interested_party[:role]
      end
      
      import_ipi = @import_ipis.find {|import_ipi|
        import_ipi.ipi_code  == interested_party[:ipi_number] &&
        import_ipi.full_name == interested_party[:full_name]  &&
        import_ipi.role_code == role_code                     &&
        import_ipi.society   == interested_party[:society]
      }
      unless import_ipi
        import_ipi = @account.import_ipis.create \
          ipi_code: interested_party[:ipi_number],
          full_name: interested_party[:full_name],
          role_code: role_code,
          society: interested_party[:society]
        @import_ipis << import_ipi
      end
      
      Ipi.create \
        import_ipi_id: import_ipi.id,
        common_work_id: common_work.id,
        full_name: import_ipi.full_name,
        email: import_ipi.email,
        phone_number: import_ipi.phone_number,
        perf_owned: interested_party[:own_percent],
        perf_collected: interested_party[:collect_percent],
        role: interested_party[:role]
    end
    
    common_work.save
  end
end