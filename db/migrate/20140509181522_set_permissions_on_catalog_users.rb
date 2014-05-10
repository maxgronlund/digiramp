class SetPermissionsOnCatalogUsers < ActiveRecord::Migration
  def up
    
    add_column :catalog_users, :permission_version,         :integer, default: 0

    
    add_column :catalog_users, :create_recordings,          :boolean, default: false
    add_column :catalog_users, :read_recordings,            :boolean, default: false
    add_column :catalog_users, :update_recordings,          :boolean, default: false
    add_column :catalog_users, :delete_recordings,          :boolean, default: false
    
    add_column :catalog_users, :create_recording_ipis,      :boolean, default: false
    add_column :catalog_users, :read_recording_ipis,        :boolean, default: false
    add_column :catalog_users, :update_recording_ipis,      :boolean, default: false
    add_column :catalog_users, :delete_recording_ipis,      :boolean, default: false
    
    add_column :catalog_users, :create_files,               :boolean, default: false
    add_column :catalog_users, :read_files,                 :boolean, default: false
    add_column :catalog_users, :update_files,               :boolean, default: false
    add_column :catalog_users, :delete_files,               :boolean, default: false
    
    add_column :catalog_users, :create_legal_documents,     :boolean, default: false
    add_column :catalog_users, :read_legal_documents,       :boolean, default: false
    add_column :catalog_users, :update_legal_documents,     :boolean, default: false
    add_column :catalog_users, :delete_legal_documents,     :boolean, default: false
    
    add_column :catalog_users, :create_financial_documents, :boolean, default: false
    add_column :catalog_users, :read_financial_documents,   :boolean, default: false
    add_column :catalog_users, :update_financial_documents, :boolean, default: false
    add_column :catalog_users, :delete_financial_documents, :boolean, default: false
    
    add_column :catalog_users, :create_common_works,        :boolean, default: false
    add_column :catalog_users, :read_common_works,          :boolean, default: false
    add_column :catalog_users, :update_common_works,        :boolean, default: false
    add_column :catalog_users, :delete_common_works,        :boolean, default: false
    
    add_column :catalog_users, :create_common_work_ipis,    :boolean, default: false
    add_column :catalog_users, :read_common_work_ipis,      :boolean, default: false
    add_column :catalog_users, :update_common_work_ipis,    :boolean, default: false
    add_column :catalog_users, :delete_common_work_ipis,    :boolean, default: false
    
    #add_column :catalog_users, :distribute_recordings,      :boolean, default: false
    


    CatalogUser.all.each do |catalog_user|
      #catalog_user.update_info = catalog_user.can_edit
      
      if catalog_user.access_files
        catalog_user.create_files                   = true
        catalog_user.read_files                     = true  
        catalog_user.update_files                   = true
        catalog_user.delete_files                   = true
      end                                         
                                                    
      if catalog_user.access_legal_documents        
        catalog_user.create_legal_documents         = true
        catalog_user.read_legal_documents           = true  
        catalog_user.update_legal_documents         = true
        catalog_user.delete_legal_documents         = true
      end
      
      if catalog_user.access_financial_documents
        catalog_user.create_financial_documents     = true
        catalog_user.read_financial_documents       = true  
        catalog_user.update_financial_documents     = true
        catalog_user.delete_financial_documents     = true
      end
      
      catalog_user.create_recordings                = catalog_user.upload_recordings
      catalog_user.read_recordings                  = true
      catalog_user.update_recordings                = catalog_user.edit_recordings
      catalog_user.delete_recordings                = catalog_user.upload_recordings
      
      catalog_user.create_common_works              = catalog_user.upload_recordings
      catalog_user.read_common_works                = true
      catalog_user.update_common_works              = catalog_user.edit_recordings
      catalog_user.delete_common_works              = catalog_user.upload_recordings
      catalog_user.save!
    end

  end
  
  
  def down
              
    remove_column :catalog_users, :permission_version 
    remove_column :catalog_users, :create_recordings          
    remove_column :catalog_users, :read_recordings           
    remove_column :catalog_users, :update_recordings          
    remove_column :catalog_users, :delete_recordings          
    
    remove_column :catalog_users, :create_recording_ipis      
    remove_column :catalog_users, :read_recording_ipis        
    remove_column :catalog_users, :update_recording_ipis      
    remove_column :catalog_users, :delete_recording_ipis      
    
    remove_column :catalog_users, :create_files               
    remove_column :catalog_users, :read_files                 
    remove_column :catalog_users, :update_files               
    remove_column :catalog_users, :delete_files               
    
    remove_column :catalog_users, :create_legal_documents     
    remove_column :catalog_users, :read_legal_documents       
    remove_column :catalog_users, :update_legal_documents     
    remove_column :catalog_users, :delete_legal_documents     
    
    remove_column :catalog_users, :create_financial_documents 
    remove_column :catalog_users, :read_financial_documents   
    remove_column :catalog_users, :update_financial_documents 
    remove_column :catalog_users, :delete_financial_documents 
    
    remove_column :catalog_users, :create_common_works        
    remove_column :catalog_users, :read_common_works         
    remove_column :catalog_users, :update_common_works       
    remove_column :catalog_users, :delete_common_works       
    
    remove_column :catalog_users, :create_common_work_ipis  
    remove_column :catalog_users, :read_common_work_ipis    
    remove_column :catalog_users, :update_common_work_ipis  
    remove_column :catalog_users, :delete_common_work_ipis   

    
    
    
    
  end
end
