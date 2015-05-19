class SetDefaultValuesOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => 'Customer'
  end
end
