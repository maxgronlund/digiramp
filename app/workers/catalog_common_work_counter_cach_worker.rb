class CatalogCommonWorkCounterCachWorker
  include Sidekiq::Worker
  
  def perform( catalog_id )
    catalog = Catalog.cached_find(catalog_id)
    catalog.count_common_works
    catalog.save!
    
    account                     = catalog.account
    #Statistics.first.recordings = Recording.size
    #Statistics.first
  end
end