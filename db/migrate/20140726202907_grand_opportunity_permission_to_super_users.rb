class GrandOpportunityPermissionToSuperUsers < ActiveRecord::Migration
  def change
    CatalogUser.super_users.each do |catalog_user|
      catalog_user.create_opportunity = true 
      catalog_user.read_opportunity   = true 
      catalog_user.update_opportunity = true 
      catalog_user.delete_opportunity = true
      catalog_user.save!
    end
    
    AccountUser.supers.each do |account_user|
      account_user.create_opportunity = true 
      account_user.read_opportunity   = true 
      account_user.update_opportunity = true 
      account_user.delete_opportunity = true
      account_user.save!
    end
  end
end
