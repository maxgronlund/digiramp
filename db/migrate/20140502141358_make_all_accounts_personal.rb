class MakeAllAccountsPersonal < ActiveRecord::Migration
  def change
    
    Account.all.each do |account|
      account.account_type = 'Personal Account'
      account.save!
    end
  end
end
