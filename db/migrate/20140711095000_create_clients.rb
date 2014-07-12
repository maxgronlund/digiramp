class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :account, index: true
      t.string :user_uuid         ,:default => ''
      t.string :name              ,:default => ''
      t.string :last_name         ,:default => ''
      t.string :user_uuid         ,:default => ''
      t.string :title             ,:default => ''
      t.string :photo             ,:default => ''
      t.string :telephone_home    ,:default => ''
      t.string :telephone_work    ,:default => ''
      t.string :fax_work          ,:default => ''
      t.string :fax_home          ,:default => ''
      t.string :cell_phone        ,:default => ''
      t.string :company           ,:default => ''
      t.string :capacity          ,:default => ''
      t.text   :address_home      ,:default => ''
      t.text   :address_work      ,:default => ''
      t.string :city_work         ,:default => ''
      t.string :state_work        ,:default => ''
      t.string :zip_work          ,:default => ''
      t.string :country_work      ,:default => ''
      t.string :email             ,:default => ''
      t.string :home_page         ,:default => ''
      t.string :department        ,:default => ''
      t.string :revision          ,:default => ''

      t.timestamps
    end
    
    add_column :account_users, :create_client, :boolean, default: false
    add_column :account_users, :read_client, :boolean, default: false
    add_column :account_users, :update_client, :boolean, default: false
    add_column :account_users, :delete_client, :boolean, default: false
    
   
    
    AccountUser.supers.each do |super_account_user|
      
      super_account_user.create_client = true
      super_account_user.read_client   = true
      super_account_user.update_client = true
      super_account_user.delete_client = true
      super_account_user.save!

      
    end
    
    AccountUser.owners.each do |super_account_user|
      
      super_account_user.create_client = true
      super_account_user.read_client   = true
      super_account_user.update_client = true
      super_account_user.delete_client = true
      super_account_user.save!

      
    end

  end
end
