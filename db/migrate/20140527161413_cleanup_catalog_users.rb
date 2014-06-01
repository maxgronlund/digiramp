class CleanupCatalogUsers < ActiveRecord::Migration
  def up
    remove_column :catalog_users, :permission_version
    remove_column :catalog_users, :edit_recordings
    remove_column :catalog_users, :upload_recordings
    
    remove_column :catalog_users, :read_works
    remove_column :catalog_users, :edit_works
    
    remove_column :catalog_users, :create_playlists
    
    remove_column :catalog_users, :can_edit
    remove_column :catalog_users, :access_files
    remove_column :catalog_users, :access_legal_documents
    remove_column :catalog_users, :access_financial_documents
    remove_column :catalog_users, :access_ipis
    
    
    
    

  end
      

  
  def down
    add_column :catalog_users, :permission_version, :integer, default: 0
    
    add_column :catalog_users, :edit_recordings,   :boolean, default: false
    add_column :catalog_users, :upload_recordings, :boolean, default: false
    
    add_column :catalog_users, :read_works                    ,   :boolean, default: false
    add_column :catalog_users, :edit_works                    ,   :boolean, default: false
    add_column :catalog_users, :create_playlists              ,   :boolean, default: false
    add_column :catalog_users, :can_edit                      ,   :boolean, default: false
    add_column :catalog_users, :access_files                  ,   :boolean, default: false
    add_column :catalog_users, :access_legal_documents        ,   :boolean, default: false
    add_column :catalog_users, :access_financial_documents    ,   :boolean, default: false
    add_column :catalog_users, :access_ipis                   ,   :boolean, default: false
    
    
  end
end
