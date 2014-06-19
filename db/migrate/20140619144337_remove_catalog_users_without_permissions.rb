class RemoveCatalogUsersWithoutPermissions < ActiveRecord::Migration
  def change
    
    CatalogUser.all.each do |catalog_user|
      delete_catalog_user = true
      
      delete_catalog_user = false if catalog_user.read_recording
      delete_catalog_user = false if catalog_user.read_recording_ipi
      delete_catalog_user = false if catalog_user.read_file
      delete_catalog_user = false if catalog_user.read_legal_document
      delete_catalog_user = false if catalog_user.read_financial_document
      delete_catalog_user = false if catalog_user.read_common_work
      delete_catalog_user = false if catalog_user.read_common_work_ipi
    
    
      catalog_user.destroy if delete_catalog_user
    end
  end
end
