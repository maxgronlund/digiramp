class AddUAccountRefToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_reference :shop_stripe_transfers, :account, index: true, foreign_key: true
    add_column :accounts, :stripe_flat_transfer_fee, :integer, default: 10
    add_column :accounts, :stripe_percent_transfer_fee, :decimal, default: 0.01
    
    Account.find_each do |account|
      account.stripe_flat_transfer_fee    = 25
      account.stripe_percent_transfer_fee = 0.01
      account.save(validate: false)
    end
    
  end
end
