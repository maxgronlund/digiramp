class UpdateEmailOnCatalogUsers < ActiveRecord::Migration
  def change
    
    CatalogUser.all.each do |catalog_user|
      if catalog_user.email != catalog_user.user.email
        catalog_user.email = catalog_user.user.email
        catalog_user.save!
        puts catalog_user.email
      end
    end
    
    Catalog.where(title: nil).destroy_all
    
  end
  
  
end
