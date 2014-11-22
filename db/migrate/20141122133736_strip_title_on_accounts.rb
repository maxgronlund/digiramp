class StripTitleOnAccounts < ActiveRecord::Migration
  def change
    
    Account.find_each do |account|
      account.title = account.title.strip
      account.save!
    end
  end
end
