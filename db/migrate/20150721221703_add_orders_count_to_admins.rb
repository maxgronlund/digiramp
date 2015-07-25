class AddOrdersCountToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :orders_count, :integer, default: 1321
  end
end
