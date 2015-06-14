class BuildCatalogUsers < ActiveRecord::Migration
  def up
    
    # update role on super users
    AccountUser.all.each do |account_user|
      if account_user.role == 'Client'
        account_user.role = 'Client User'
        account_user.save!
      end
    end
    
    # update role on accont owners
    Account.all.each do |account|
      user = User.find(account.user_id)
      
      
      if account_user = AccountUser.where(user_id: account.user_id, account_id: account.id).first
        
        #ap account_user
        account_user.role = 'Account Owner'
        account_user.save!
      else
        puts "no account user for #{account.title}"
        
        account_user = AccountUser.create(account_id: account.id, user_id: user.id, role: 'Account Owner')
        account_user.grand_all_permissions
        
      end
    end
    
    Catalog.all.each do |catalog|
      puts '----------------------------------'
      puts catalog.title
      
      catalog.account.account_users.each do |account_user|
        puts "#{account_user.role} : #{account_user.user.email}"
        
        if account_user.role == 'Account Owner' || account_user.role == 'Administrator'

          catalog_user = CatalogUser.create(user_id: account_user.user_id,
                                            catalog_id: catalog.id,
                                            role: account_user.role,
                                            account_id: catalog.account_id,
                                            uuid:       UUIDTools::UUID.timestamp_create().to_s
                                            )
          catalog_user.grand_all_permissions
        
        # remove corupted catalog users  
        elsif account_user.role == 'Catalog User'
          account_user.destroy!
        end
        
        
      end
    end
  end
  
  def down
    CatalogUser.destroy_all
    Catalog.where(title: nil).destroy_all
  end
end
