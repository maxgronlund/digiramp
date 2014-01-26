class AscapScraperWorker
  include Sidekiq::Worker
  
  def perform import_klass_name, common_works_import_id
    import_klass = case import_klass_name
    when 'AscapMemberScrape'
      Scraper::AscapMemberScrape::Import
    when 'AscapScraper'
      Scraper::AscapScraper::Import
    end
    
    import_klass.new.start(common_works_import_id)
  end
end