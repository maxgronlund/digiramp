class AddActivatedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :activated, :boolean, default: true
  end
end
