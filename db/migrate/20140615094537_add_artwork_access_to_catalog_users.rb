class AddArtworkAccessToCatalogUsers < ActiveRecord::Migration
  def change
    add_column :account_users,  :create_artwork, :boolean,       default: true
    add_column :account_users,    :read_artwork, :boolean,       default: true
    add_column :account_users,  :update_artwork, :boolean,       default: true
    add_column :account_users,  :delete_artwork, :boolean,       default: true
    
    add_column :catalog_users,  :create_artwork, :boolean,       default: true
    add_column :catalog_users,    :read_artwork, :boolean,       default: true
    add_column :catalog_users,  :update_artwork, :boolean,       default: true
    add_column :catalog_users,  :delete_artwork, :boolean,       default: true
    
  end
end
