class AddArtworkToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :artwork, :string
    

    
    remove_column :account_users, :access_to_all_recordings, :boolean,                  default: false   
    remove_column :account_users, :access_to_all_common_works, :boolean,                default: false 
    remove_column :account_users, :access_to_all_rights, :boolean,                      default: false       
    remove_column :account_users, :access_to_all_documents, :boolean,                   default: false    
    remove_column :account_users, :access_to_collect, :boolean,                         default: false    
    remove_column :account_users, :administrate_playlists, :boolean,                         default: false 
    
    
    
  end
end
