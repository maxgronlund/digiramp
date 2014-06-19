class AddPermittedUsers < ActiveRecord::Migration
  def change
    
    Account.all.each do |account|
      unless account.permitted_user_ids.include? account.user_id
        account.permitted_user_ids << account.user_id 
        account.save!
      end
    end
    
    AccountUser.all.each do |account_user|
      
      account_user.account.catalogs.each do |catalog|
        catalog_user = CatalogUser.where( user_id:    account_user.user_id, 
                                          catalog_id: catalog.id
                                        )
                                  .first_or_create(  user_id:     account_user.user_id, 
                                                      catalog_id: catalog.id         
                                                   )
        catalog_user.account_user_id = account_user.id
        catalog_user.save!
        
        catalog_user.copy_permissions_from_account_user account_user
                                                                  
      end
      
      
    end
  end
end
