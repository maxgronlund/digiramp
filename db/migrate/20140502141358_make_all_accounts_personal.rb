class MakeAllAccountsPersonal < ActiveRecord::Migration
  def change
    
    Account.all.each do |account|
      account.account_type = 'Social'
      account.save!
    end
  end
end
