class CreateAccountPrices < ActiveRecord::Migration
  def change
    create_table :account_prices do |t|
      t.decimal :subscription_fee
      t.string :account_type
      t.timestamps
    end
    
    AccountPrice.create(subscription_fee: 0.0, account_type: 'Social')
    AccountPrice.create(subscription_fee: 19.0, account_type: 'Pro')
    AccountPrice.create(subscription_fee: 149.0, account_type: 'Business')
    AccountPrice.create(subscription_fee: 5000.0, account_type: 'Enterprise')
    
    
    add_column :accounts, :subscription_fee, :decimal, default: 0.0
    add_column :accounts, :special_subscription_fee, :boolean, default: false

    
    Account.find_each do |account|
      if account.account_type == 'Pro'
        account.subscription_fee = 19.0
      else
        account.subscription_fee = 0.0
      end
      account.special_subscription_fee = false
      account.save!
    end
  end
end
