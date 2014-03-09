class AddPermissionsToAccountUsers < ActiveRecord::Migration
  def change
    add_column :account_users, :access_to_all_recordings, :boolean,       default: false
    add_column :account_users, :access_to_all_common_works, :boolean,     default: false
    add_column :account_users, :access_to_all_rights, :boolean,           default: false
    add_column :account_users, :access_to_all_documents, :boolean ,       default: false
    add_column :account_users, :access_to_collect, :boolean ,             default: false
  end
end
