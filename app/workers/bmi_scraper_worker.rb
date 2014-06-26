# to do timeout, error handling, wrong password

class BmiScraperWorker
  require_relative '../../lib/rights_scrapers/bmi/bmi_scraper'
  include Sidekiq::Worker
  sidekiq_options :retry => false 
  


  def perform user_name, password, common_works_import_id
    
    works = []
    common_works_import = CommonWorksImport.cached_find(common_works_import_id)
    
    import_started = true

    BMIMemberWorkCollect.scrape user_name, password do |work|
      #puts "\n\nWork:"
      works << work
      if import_started
        CommonWorksImport.post_bmi_info common_works_import.user_email, work
        import_started = false
      end
      #ap work
    end
    
    if works != []
      common_works_import.params = works
      common_works_import.save!
      #ap common_works_import
      common_works_import.parse_works_from_bmi
    else
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
      puts 'ERROR: Unable to extract common works: works_details nil'
      puts 'In AscapScraperWorker#perform'
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
      CommonWorksImport.post_info common_works_import.user_email, {error: 'works_details nil'}
    end
    

  end
end