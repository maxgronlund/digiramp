class UpgradeCatalogUsers < ActiveRecord::Migration
  def change
    
    rename_column :account_users, :create_account_user, :createx_user
    rename_column :account_users,   :read_account_user,   :read_user
    rename_column :account_users, :update_account_user, :update_user
    rename_column :account_users, :delete_account_user, :delete_user
    
    rename_column :catalog_users, :create_recordings, :create_recording
    rename_column :catalog_users,   :read_recordings,   :read_recording
    rename_column :catalog_users, :update_recordings, :update_recording
    rename_column :catalog_users, :delete_recordings, :delete_recording
    
    rename_column :catalog_users, :create_common_works,  :create_common_work
    rename_column :catalog_users,   :read_common_works,    :read_common_work
    rename_column :catalog_users, :update_common_works,  :update_common_work
    rename_column :catalog_users, :delete_common_works,  :delete_common_work
    
    rename_column :catalog_users, :create_common_work_ipis,  :create_common_work_ipi
    rename_column :catalog_users,   :read_common_work_ipis,    :read_common_work_ipi
    rename_column :catalog_users, :update_common_work_ipis,  :update_common_work_ipi
    rename_column :catalog_users, :delete_common_work_ipis,  :delete_common_work_ipi
    
    rename_column :catalog_users, :create_recording_ipis,  :create_recording_ipi
    rename_column :catalog_users, :read_recording_ipis  ,    :read_recording_ipi 
    rename_column :catalog_users, :update_recording_ipis,  :update_recording_ipi
    rename_column :catalog_users, :delete_recording_ipis,  :delete_recording_ipi
    
    rename_column :catalog_users, :create_files,  :create_file
    rename_column :catalog_users,   :read_files,    :read_file 
    rename_column :catalog_users, :update_files,  :update_file
    rename_column :catalog_users, :delete_files,  :delete_file
    
    rename_column :catalog_users, :create_legal_documents,  :create_legal_document
    rename_column :catalog_users,   :read_legal_documents,    :read_legal_document 
    rename_column :catalog_users, :update_legal_documents,  :update_legal_document
    rename_column :catalog_users, :delete_legal_documents,  :delete_legal_document
    
    rename_column :catalog_users, :create_financial_documents,  :create_financial_document
    rename_column :catalog_users,   :read_financial_documents,    :read_financial_document 
    rename_column :catalog_users, :update_financial_documents,  :update_financial_document
    rename_column :catalog_users, :delete_financial_documents,  :delete_financial_document
    
    
    
    add_column :catalog_users, :create_comment,   :boolean, default: true
    add_column :catalog_users,   :read_comment,   :boolean, default: true
    add_column :catalog_users, :update_comment,   :boolean, default: true
    add_column :catalog_users, :delete_comment,   :boolean, default: true
    
    add_column :catalog_users, :createx_user,     :boolean, default: false
    add_column :catalog_users,   :read_user,      :boolean, default: false
    add_column :catalog_users, :update_user,      :boolean, default: false
    add_column :catalog_users, :delete_user,      :boolean, default: false
    
    add_column :catalog_users, :create_playlist,  :boolean, default: false
    add_column :catalog_users,   :read_playlist,  :boolean, default: false
    add_column :catalog_users, :update_playlist,  :boolean, default: false
    add_column :catalog_users, :delete_playlist,  :boolean, default: false
    
    add_column :catalog_users, :create_catalog,  :boolean, default: false
    add_column :catalog_users,   :read_catalog,  :boolean, default: true
    add_column :catalog_users, :update_catalog,  :boolean, default: false
    add_column :catalog_users, :delete_catalog,  :boolean, default: false
    
    add_column :catalog_users, :create_crm,       :boolean, default: false
    add_column :catalog_users,   :read_crm,       :boolean, default: false
    add_column :catalog_users, :update_crm,       :boolean, default: false
    add_column :catalog_users, :delete_crm,       :boolean, default: false
        
    add_column :catalog_users, :uuid,  :string,   default: 'chunky beacon'
    
    add_column :catalog_users, :role, :string, default: 'Catalog User'
    add_column :catalog_users, :account_user_id, :integer
    
    add_index :catalog_users, :account_user_id
    
    
        
    
  
    CatalogUser.all.each do |catalog_user|
      catalog_user.uuid = UUIDTools::UUID.timestamp_create().to_s
      catalog_user.save!
    end
    
    
  end
end
