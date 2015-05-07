class AddCardholdersNameXToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cardholders_name, :string
    remove_column :subscriptions, :email_address
  end
end
