class AddMandrillAccountIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mandrill_account_id, :string
    
    User.find_each do |user|
      begin 
        MandrillAccountService.create_account_for_user user.id
      rescue
        ap '--------------------------- error----------------------------'
        ap user
      end
    end
  end
end
