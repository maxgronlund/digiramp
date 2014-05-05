class CreateCatalogablePermissions < ActiveRecord::Migration
  def change
    add_column :recordings, :artwork, :string, default: '' 
    add_column :recordings, :original_file, :string, default: '' 
    
    create_table :catalogable_permissions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :catalog_item, index: true
      
    
      t.boolean  "can_edit",                   default: false
      t.boolean  "access_files",               default: false
      t.boolean  "access_legal_documents",     default: false
      t.boolean  "access_financial_documents", default: false
      t.boolean  "access_ipis",                default: false
      t.boolean  "edit_recordings",            default: false
      t.boolean  "upload_recordings",          default: false
      t.boolean  "read_works",                 default: false
      t.boolean  "edit_works",                 default: false
      t.boolean  "create_playlists",           default: false
    
      t.timestamps
    end
    #
    #CatalogUser.all.each do |catalog_user|
    #
    #  CatalogablePermission.create(
    #                                user_id:                      catalog_user.user,
    #                                can_edit:                     catalog_user.can_edit,                                                 
    #                                access_files:                 catalog_user.access_files,           
    #                                access_legal_documents:       catalog_user.access_legal_documents,  
    #                                access_financial_documents:   catalog_user.access_financial_documents,
    #                                access_ipis:                  catalog_user.access_ipis, 
    #                                edit_recordings:              catalog_user.edit_recordings,         
    #                                upload_recordings:            catalog_user.upload_recordings,        
    #                                read_works:                   catalog_user.read_works,              
    #                                edit_works:                   catalog_user.edit_works,              
    #                                create_playlists:             catalog_user.create_playlists  
    #  
    #  
    #  
    #                              )
    #  
    #  
    #  
    #end
  end
end
