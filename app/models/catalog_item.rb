class CatalogItem < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :catalog
  belongs_to :catalog_itemable, polymorphic: true
  
  #after_create   :update_catalog_counter_cache
  #before_destroy :remove_linked_assets
  #after_destroy  :update_catalog_counter_cache
  
  # premature uptimization
  #def update_catalog_counter_cache
  #
  #  case self.catalog_itemable_type
  #
  #  when 'CommonWork'
  #    'count commonworks'
  #    CatalogCommonWorkCounterCachWorker.perform_async(self.catalog_id)
  #  when 'Recording'
  #    CatalogRecordingCounterCachWorker.perform_async(self.catalog_id)
  #  when 'Document', 'Artwork'
  #    CatalogDocumentCounterCachWorker.perform_async(self.catalog_id)
  #  end
  #
  #end
  
  # when some kind of catalog items are removed
  # there is assets that has to follow
  #def remove_linked_assets
  #  case self.catalog_itemable_type
  #  when 'CommonWork'
  #    remove_recordings
  #  end
  #end
  #
  #def remove_recordings
  #  begin
  #    common_work =   self.catalog_itemable
  #    common_work.recordings.each do |recording|
  #      catalog_item = CatalogItem.where(
  #                        catalog_id: self.catalog_id, 
  #                        catalog_itemable_id: recording.id, 
  #                        catalog_itemable_type: recording.class.name 
  #                      ).first
  #      catalog_item.destroy! if catalog_item
  #    end
  #  rescue
  #    #puts '>>>>>>>>>>>>>>>>>> no recordings removed <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
  #  end
  #end
  
  def self.cached_find(id)
    begin
      return Rails.cache.fetch([name, id]) { find(id) }
    rescue
      return nil
    end
  end

private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
