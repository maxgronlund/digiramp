class AddVersionToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :version, :integer, default: 0
  end
end
