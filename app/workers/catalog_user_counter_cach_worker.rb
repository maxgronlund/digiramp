class CatalogUserCounterCachWorker
  include Sidekiq::Worker
  
  def perform( catalog_id )
    catalog = Catalog.cached_find(catalog_id)
    catalog.count_users
    catalog.save!
  end
end