class AddSubscriptionFeeToAccountFeatures < ActiveRecord::Migration
  def change
    add_column :account_features, :subscription_fee, :decimal, default: 0.0 
  end
end
