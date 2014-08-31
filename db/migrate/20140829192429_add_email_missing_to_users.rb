class AddEmailMissingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_missing, :boolean, default: false
  end
end
