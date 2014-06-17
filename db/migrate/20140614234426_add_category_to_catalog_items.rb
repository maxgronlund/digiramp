class AddCategoryToCatalogItems < ActiveRecord::Migration
  def change
    add_column :catalog_items, :category, :string , default: ''
    
    CatalogItem.all.each do |catalog_item|
      
      catalog_item.category = catalog_item.catalog_itemable_type
      catalog_item.save!
      
    end
    
    
  end
end
