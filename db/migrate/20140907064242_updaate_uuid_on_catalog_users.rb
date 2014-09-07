class UpdaateUuidOnCatalogUsers < ActiveRecord::Migration
  def change
    CatalogUser.all.each do |catalog_user|
      
      catalog_user.uuid = UUIDTools::UUID.timestamp_create().to_s
      catalog_user.save!
    end
  end
end
