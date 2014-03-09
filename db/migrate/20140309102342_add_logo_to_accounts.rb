class AddLogoToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :logo, :string
  end
end
