class RenameOppertunity < ActiveRecord::Migration

  def self.up
      rename_table :oppertunities, :opportunities
      
      rename_column :account_users, :create_oppertunity,  :create_opportunity
      rename_column :account_users,   :read_oppertunity  ,  :read_opportunity  
      rename_column :account_users, :update_oppertunity,  :update_opportunity
      rename_column :account_users, :delete_oppertunity,  :delete_opportunity
                                  
      rename_column :catalog_users, :create_oppertunity,  :create_opportunity
      rename_column :catalog_users,   :read_oppertunity  ,  :read_opportunity  
      rename_column :catalog_users, :update_oppertunity,  :update_opportunity
      rename_column :catalog_users, :delete_oppertunity,  :delete_opportunity
      
  end
  
  def self.down
     rename_table :opportunities, :oppertunities
     
     rename_column :account_users, :create_opportunity,  :create_oppertunity
     rename_column :account_users,   :read_opportunity  ,  :read_oppertunity  
     rename_column :account_users, :update_opportunity,  :update_oppertunity
     rename_column :account_users, :delete_opportunity,  :delete_oppertunity
                                                                   
     rename_column :catalog_users, :create_opportunity,  :create_oppertunity
     rename_column :catalog_users,   :read_opportunity  ,  :read_oppertunity  
     rename_column :catalog_users, :update_opportunity,  :update_oppertunity
     rename_column :catalog_users, :delete_opportunity,  :delete_oppertunity
     
  end
  
end
