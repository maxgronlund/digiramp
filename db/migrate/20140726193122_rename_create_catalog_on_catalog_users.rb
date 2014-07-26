class RenameCreateCatalogOnCatalogUsers < ActiveRecord::Migration
  def change
    
    rename_column :catalog_users, :create_catalog, :createx_catalog
    rename_column :account_users, :create_catalog, :createx_catalog
  end
end
