class AddSalespersonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salesperson, :boolean, default: false
  end
end
