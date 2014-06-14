class RepairPermissionsWorker
  include Sidekiq::Worker
  
  # !!! update or delete
  def perform
    
    #Account.all.each do |account|
    #  account.repair_users
    #end
    #
    #CatalogUser.all.each do |catalog_user|
    #  # secure the is an account user for all catalog users
    #  catalog_user.attach_to_account_user
    #  
    #  # secure that all administrators and supers has all permissions
    #  if catalog_user.account_user.role == 'Administrator' || catalog_user.account_user.role == 'Super'
    #    catalog_user.grand_all_permissions
    #  end
    #
    #end
    #
    
    
    
    #AccountUser.all.each do |account_user|
    #  account_user.check_permissions
    #  account_user.update_catalog_user
    #end
    
    
  end
  

end