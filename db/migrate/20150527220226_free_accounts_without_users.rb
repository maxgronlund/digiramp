class FreeAccountsWithoutUsers < ActiveRecord::Migration
  def change
    no_ones_accounts = []
    Account.find_each do |account|
      unless account.user
        no_ones_accounts << account.id
      end
    end
    ap '----------------- accounts without a user -----------------------'
    ap no_ones_accounts
    ap '================================================================='
    
    user_account_ids  = User.pluck(:account_id)
    account_ids       = Account.pluck(:id)
    
    ap '----------------- a------------------------------'
    ap account_ids - user_account_ids - no_ones_accounts
    ap '================================================================='
  end
end
