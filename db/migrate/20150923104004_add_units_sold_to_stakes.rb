class AddUnitsSoldToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :units_sold, :integer, default: 0
    change_column :shop_stripe_transfers, :payment_fee, :integer, default: 0
  end
end
