class CatalogRecordingCounterCachWorker
  include Sidekiq::Worker
  
  def perform( catalog_id )
    catalog = Catalog.cached_find(catalog_id)
    catalog.count_recordings
    catalog.save!
  end
end