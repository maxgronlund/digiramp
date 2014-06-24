class AddOpertunitiesToAccountUsers < ActiveRecord::Migration
  def change
    add_column :catalog_users, :create_oppertunity, :boolean, derault: false
    add_column :catalog_users,   :read_oppertunity, :boolean, derault: false
    add_column :catalog_users, :update_oppertunity, :boolean, derault: false
    add_column :catalog_users, :delete_oppertunity, :boolean, derault: false
  end
end
