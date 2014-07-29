class AddAccountActivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_activated, :boolean, default: true
  end
end
