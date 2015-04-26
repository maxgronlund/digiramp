class RemoveSubscriptionFeeFromAccountFeatures < ActiveRecord::Migration
  def change
    remove_column :account_features, :subscription_fee, :string
    
  end
end
