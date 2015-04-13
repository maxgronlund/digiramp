class AddQuantityToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :quantity, :integer, default: 1
    Registration.update_all(quantity: 1)
  end
end
