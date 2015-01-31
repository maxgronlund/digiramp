class AddCreateClientToCatalogUsers < ActiveRecord::Migration
  def change
    add_column :catalog_users, :create_client, :boolean, default: false
    add_column :catalog_users, :read_client, :boolean, default: false
    add_column :catalog_users, :update_client, :boolean, default: false
    add_column :catalog_users, :delete_client, :boolean, default: false
  end
end
