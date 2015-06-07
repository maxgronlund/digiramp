class AddAccountTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_type, :string, default: 'Social'
    
    User.find_each do |user|
      
      if account = user.account
        if account_feature = account.account_feature
          user.account_type =  account_feature.account_type
          user.save(validate: false)
        end
      end
    end
  end
end
