class AttachWorks < ActiveRecord::Migration
  def change
    

    Account.all.each do |account|
      catalog = Catalog.create(account_id: account.id, title: "Default catalog")
      account.default_catalog_id = catalog.id
      account.save!
      
      #account.common_works.each do |common_work|
      #  CatalogItem.create(catalog_itemable_id: common_work.id, catalog_itemable_type: common_work.class.name, catalog_id: catalog.id)
      #end
    end
    
  end
end
