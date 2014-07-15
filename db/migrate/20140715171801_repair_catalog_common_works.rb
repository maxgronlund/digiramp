class RepairCatalogCommonWorks < ActiveRecord::Migration
  def change
    
    catalog_recording_items = CatalogItem.where(catalog_itemable_type: 'Recording')
    
    catalog_recording_items.each do |catalog_recording_item|
      recording = catalog_recording_item.catalog_itemable

      catalog       = catalog_recording_item.catalog
      common_work   = recording.common_work
      
      
      CatalogItem.where( catalog_itemable_type: 'CommonWork', 
                         catalog_itemable_id:  common_work.id,
                         catalog_id: catalog.id
                        )
                  .first_or_create( catalog_itemable_type: 'CommonWork', 
                                    catalog_itemable_id:  common_work.id,
                                    catalog_id: catalog.id
                                   )
    end
  end
end
