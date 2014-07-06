class FixCatalogUsers < ActiveRecord::Migration
  def change
    
    AccountUser.where(role: 'Catalog User').all do |account_user|
      #check_if
      
    end
  end
end
