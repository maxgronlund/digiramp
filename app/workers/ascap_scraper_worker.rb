class AscapScraperWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false 
  
  
  
  #sidekiq_retries_exhausted do |msg|
  #  Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  #end

  def perform user_name, password, account_id, catalog_id, title, body, pro, user_email
    
    

    common_works_import = CommonWorksImport.new(
                                                    account_id: account_id.to_i,
                                                    catalog_id: catalog_id.to_i,
                                                    title:      title,
                                                    body:       body,
                                                    pro:        pro,
                                                    user_email: user_email,
                                                    in_progress: true
                                                 )
    
    scrape = Scraper::AscapMemberScrape.new user_name, password

    scrape.start do |info|

      if info[:error] 
         CommonWorksImport.post_info user_email, {error: 'error'}
      else
        #ap info
        #puts "\n-------------- INFO ------------------\n"
        #CommonWorksImport.post_info user_email, info
      end
      
    end
    #puts "\n\n"
    #puts "Results: \n"
    #ap scrape.works_details
    
    if scrape.works_details
      common_works_import.params = scrape.works_details
      common_works_import.save!
      common_works_import.parse_common_works
    else
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
      puts 'ERROR: Unable to extract common works: works_details nil'
      puts 'In AscapScraperWorker#perform'
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    end
  end
end