class AttachCatalogUsersToAccounts < ActiveRecord::Migration
  def change
    
    CatalogUser.all.each do |catalog_user|
       catalog_user.account_id = catalog_user.catalog.account_id
       catalog_user.save!
    end
  end
end
