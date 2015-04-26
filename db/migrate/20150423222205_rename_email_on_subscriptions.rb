class RenameEmailOnSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :email, :email_address
  end
end
