# new abstraction layer for workers from rails 4.2

#class AscapScraperWorker
#  include Sidekiq::Worker
#  sidekiq_options :retry => false 
#
#  def perform user_name, password, common_works_import_id
#    
#    common_works_import = CommonWorksImport.cached_find(common_works_import_id)
#
#   
#    scrape = Scraper::AscapMemberScrape.new user_name, password
#
#    scrape.start do |info|
#
#      if info[:error] 
#         CommonWorksImport.post_info common_works_import.user_email, {error: 'error'}
#      else
#        #ap info
#        #CommonWorksImport.post_info common_works_import.user_email, info
#      end
#      
#    end
#    #puts "\n\n"
#    #puts "Results: \n"
#    #ap scrape.works_details
#    
#    if scrape.works_details
#      common_works_import.params = scrape.works_details
#      common_works_import.save!
#      common_works_import.parse_common_works
#    else
#      puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
#      puts 'ERROR: Unable to extract common works: works_details nil'
#      puts 'In AscapScraperWorker#perform'
#      puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
#      CommonWorksImport.post_info common_works_import.user_email, {error: 'works_details nil'}
#    end
#  end
#end