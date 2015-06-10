class AddErrorsToStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :stripe_errors, :string
  end
end
