class AddStateToShopTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :state, :string, default: 'pending'
    #add_column :shop_stripe_transfers, :source_transaction, :string
    add_column :shop_stripe_transfers, :currency, :string
    
    
    Shop::StripeTransfer.update_all(state: 'pending')
  end
end
