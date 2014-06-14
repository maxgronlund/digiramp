class MoveCommonWorksToCatalogs < ActiveRecord::Migration
  def change
    
    # get all the recordings
    catalog_items = CatalogItem.where(catalog_itemable_type: 'Recording')
    
    
    catalog_items.each do |catalog_item|
      catalog         =  catalog_item.catalog
      recording       =  catalog_item.catalog_itemable
      common_work     =  recording.common_work
      # add common_work to catalog
      common_work.add_to_catalog catalog
    end
  end
  
  
  
end
