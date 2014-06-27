class GrandPermissiosToIpisAndOpportunities < ActiveRecord::Migration
  def up
    
    rename_column :accounts, :create_oppertunities, :create_opportunities
    rename_column :accounts, :read_oppertunities, :read_opportunities
    update_permissions
  end
  
  def down
    
    rename_column :accounts, :create_opportunities, :create_oppertunities
    rename_column :accounts, :read_opportunities, :read_oppertunities
    update_permissions
  end
  
  def update_permissions
    CatalogUser.super_users.each do |catalog_user|
      
      catalog_user.create_opportunity = true
      catalog_user.read_opportunity   = true
      catalog_user.update_opportunity = true
      catalog_user.delete_opportunity = true
      catalog_user.save!
    end
    
    CatalogUser.account_owners.each do |catalog_user|
      
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
    
    AccountUser.owners.each do |account_user|
      account_user.create_opportunity = true
      account_user.read_opportunity   = true
      account_user.update_opportunity = true
      account_user.delete_opportunity = true
      account_user.save!
    end
    
  end
end
