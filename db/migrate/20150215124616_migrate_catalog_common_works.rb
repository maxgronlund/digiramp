class MigrateCatalogCommonWorks < ActiveRecord::Migration
  def change
    CatalogsCommonWorks.destroy_all
    
    Catalog.find_each do |catalog|
      
      if catalog_items = CatalogItem.where(catalog_id: catalog.id, catalog_itemable_type: 'CommonWork')
        catalog_items.each do |catalog_item|
          if common_work = CommonWork.where(id: catalog_item.catalog_itemable_id).first
            ap CatalogsCommonWorks.create(catalog_id: catalog.id,  common_work_id: common_work.id )
          end
        end
      end
    end
  end
end
