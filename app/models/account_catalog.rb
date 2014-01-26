class AccountCatalog < ActiveRecord::Base
  belongs_to :account
  has_many :catalog_items, dependent: :destroy
  has_many :administrations, dependent: :destroy
  
  has_many :administrations
  has_many :users, through: :administrations
  
  
  #ROLES = ["admin", "account owner", "guest", "representative", "supervisor"]
  

  
  #def administrator
  #  if administrations.first.exists?
  #    return administrations.first.user 
  #  else
  #    return User.where(account.administrator_id).first
  #  end
  #end
  #
  #def assign_administrator user
  #  logger.debug '------------------------------------------------'
  #  logger.debug '------------------------------------------------'
  #  logger.debug '------------------------------------------------'
  #  unless Administration.exists?(account_catalog_id: id, user_id: user.id)
  #    administrations.create(account_catalog_id: id, account_id: account.id, user_id: user.id)
  #    
  #  end
  #end
  
  
end
