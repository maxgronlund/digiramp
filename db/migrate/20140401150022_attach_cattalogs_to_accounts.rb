class AttachCattalogsToAccounts < ActiveRecord::Migration
  def change
    
    drop_table :catalogs
    create_table :catalogs do |t|
      t.string :title
      t.string :body
      t.belongs_to :account, index: true

      t.timestamps
    end
    
    CatalogItem.delete_all

    add_column :accounts, :default_catalog_id, :integer
    add_index  :accounts, :default_catalog_id
    rename_column :catalog_items, :account_catalog_id, :catalog_id
  
  end
end
