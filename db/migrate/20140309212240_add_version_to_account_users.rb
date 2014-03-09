class AddVersionToAccountUsers < ActiveRecord::Migration
  def change
    add_column :account_users, :version, :integer, default: 0
  end
end
