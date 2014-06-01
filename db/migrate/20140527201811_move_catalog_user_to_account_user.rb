class MoveCatalogUserToAccountUser < ActiveRecord::Migration
  def change
    
    # kill bad catalogs
    Catalog.all.each do |catalog|
      catalog.destroy! unless Account.exists?(catalog.account_id)
    end
    
    # create an account user for all catalog users
    CatalogUser.all.each do |catalog_user|
      if Catalog.exists?(catalog_user.catalog_id) && Account.exists?(catalog_user.account_id)
        catalog_user.attach_to_account_user
      else
        catalog_user.destroy! 
      end
    end
    
    # update role names
    User.all.each do |user|
      user.role = 'Customer' if user.role.to_s == ''
      user.role = 'Customer' if user.role == 'Administrator'
      user.role = 'Super'    if user.role == 'super'
      user.save!
    end
    
    # update role names on account users
    AccountUser.all.each do |account_user|
      account_user.role = 'Account User' if account_user.role == 'Administrator'
      account_user.role = 'Super'       if account_user.user.role == 'Super'
      account_user.save!
      # grand all permissions to super users
      account_user.grand_all_permissions if account_user.user.role == 'Super'
      
      # grand all permissions to super users
      account_user.grand_all_permissions if account_user.role == 'Account Owner'
    end
    
  end
  

end
