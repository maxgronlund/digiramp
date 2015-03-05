class AccessManager
  
  # super users are users of all accounts and all catalogs
  # super users are granded all permissions
  # 
  # when a new account is created all super users are added to it
  # when a catalog is created all super users are added to it
  # 
  # when the role on a user is upgraded to 'Super' the user is added to all accounts
  # when the role on a user is upgraded to 'Super' the user is added to all catalogs
  # 
  # when the role on a user is downgraded to 'Super' the user is removed from all accounts except the users owns account
  # when the role on a user is downgraded to 'Super' the user is removed from all catalogs except the users owns catalog
    
  def self.add_to_accounts user
    Account.all.each do |account|
      account_user = AccountUser.where(account_id: account.id, user_id: user.id)
                                .first_or_create(account_id: account.id, user_id: user.id)
      account_user.update_to_super

    end
  end
  
  def self.remove_from_accounts user
    account_users = AccountUser.where( user_id: user.id)
    account_users = account_users.where.not(role: 'Account Owner')
    account_users.destroy_all
  end
  
  def self.remove_from_catalogs user
    catalog_users = CatalogUser.where( user_id: user.id)
    catalog_users = catalog_users.where.not(role: 'Account Owner')
    catalog_users.destroy_all
  end

  def self.update_access user
    
    # only do if role has changed
    if user.old_role != user.role
      user.old_role = user.role
      if user.role == 'Super'
        add_to_accounts user
      else
        remove_from_accounts user
        remove_from_catalogs user
      end
      user.save!
    end
  end
  
  def self.add_account_users_to_catalog catalog
    
    account = catalog.account

    account.account_users.where.not(role: 'Catalog User').each do |account_user|
      

      
      catalog_user = CatalogUser.create(catalog_id:       catalog.id, 
                                        user_id:          account_user.user_id, 
                                        role:             account_user.role,
                                        account_user_id:  account_user.id,
                                        account_id:       catalog.account_id,
                                        uuid:             UUIDTools::UUID.timestamp_create().to_s )
                                        
      catalog_user.copy_permissions_from_account_user account_user

    end

  end
  
  # AccessManager.add_super_users_to_account account
  def self.add_users_to_new_account account
    
    #User.supers.each do |super_user|
    #  account_user = AccountUser.where(account_id: account.id, user_id: super_user.id, role: 'Super User')     
    #                            .first_or_create(account_id: account.id, user_id: super_user.id, role: 'Super User')     
    #  account_user.update_to_super
    #end
    
    # create a account user for the account owner
    account_owner = AccountUser.where(account_id: account.id, user_id: account.user.id, role: 'Account Owner')
                               .first_or_create(account_id: account.id, user_id: account.user.id, role: 'Account Owner')
    # downgrade the owner
    #account_owner.grand_basic_permissions
    account_owner.grand_all_permissions
    
    account.count_users
    #make_zebulon_admin account

  end
  
  #def self.make_zebulon_admin account
  #  # this is a temporary thing to make peter administrator for all accounts
  #  # notice it's required that zwbulon is super
  #  if zebulon                      = User.where(email: 'peter@musicintomedia.com').first
  #    if account_administrator      = AccountUser.where(account_id: account.id, user_id: zebulon.id).first 
  #      # update the administrator
  #      account.administrator_id = zebulon.id
  #      account.save!
  #      # update the role
  #      account_administrator       = AccountUser.where(account_id: account.id, user_id: zebulon.id).first 
  #      zebulon.role= 'Administrator'
  #      account_administrator.save!
  #    end
  #  end
  #  
  #end


end

