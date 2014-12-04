class UpdatePersonalAccounts < ActiveRecord::Migration
  def change
    
    Account.find_each do |account|
      
      case account.account_type
      when 'Personal Account'
        account.account_type = 'Social'
      when 'Pro Account'
        account.account_type = 'Pro'
      when 'Enterprise Account'
        account.account_type = 'Enterprise'
      else
        account.account_type = 'Social'
      end
      account.save!
    end
  end
end
