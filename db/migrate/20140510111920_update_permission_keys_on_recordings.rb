class UpdatePermissionKeysOnRecordings < ActiveRecord::Migration
  
  def up
    
    super_user_ids  = User.where(role: 'super').pluck(:id)

    Recording.all.each do |recording|
      
      account           = recording.account
      account_user_ids  = AccountUser.where(account_id: recording.account_id).pluck(:id) || []
      
      begin
        account_user_ids << account.user_id
        account_user_ids.uniq!
        recording.create_recording_ids              = [] + super_user_ids + account_user_ids
        recording.read_recording_ids                = [] + super_user_ids + account_user_ids
        recording.update_recording_ids              = [] + super_user_ids + account_user_ids
        recording.delete_recording_ids              = [] + super_user_ids + account_user_ids
        recording.create_recording_ipis_ids         = [] + super_user_ids + account_user_ids
        recording.read_recording_ipis_ids           = [] + super_user_ids + account_user_ids
        recording.update_recording_ipis_ids         = [] + super_user_ids + account_user_ids
        recording.delete_recording_ipis_ids         = [] + super_user_ids + account_user_ids
        recording.create_files_ids                  = [] + super_user_ids + account_user_ids
        recording.read_files_ids                    = [] + super_user_ids + account_user_ids
        recording.update_files_ids                  = [] + super_user_ids + account_user_ids
        recording.delete_files_ids                  = [] + super_user_ids + account_user_ids
        recording.create_legal_documents_ids        = [] + super_user_ids + account_user_ids
        recording.read_legal_documents_ids          = [] + super_user_ids + account_user_ids
        recording.update_legal_documents_ids        = [] + super_user_ids + account_user_ids
        recording.delete_legal_documents_ids        = [] + super_user_ids + account_user_ids
        recording.create_financial_documents_ids    = [] + super_user_ids + account_user_ids
        recording.read_financial_documents_ids      = [] + super_user_ids + account_user_ids
        recording.update_financial_documents_ids    = [] + super_user_ids + account_user_ids
        recording.delete_financial_documents_ids    = [] + super_user_ids + account_user_ids
        recording.read_common_works_ids             = [] + super_user_ids + account_user_ids
        recording.update_common_works_ids           = [] + super_user_ids + account_user_ids
        recording.create_common_work_ipis_ids       = [] + super_user_ids + account_user_ids
        recording.read_common_work_ipis_ids         = [] + super_user_ids + account_user_ids
        recording.update_common_work_ipis_ids       = [] + super_user_ids + account_user_ids
        recording.delete_common_work_ipis_ids       = [] + super_user_ids + account_user_ids
        recording.save!
      rescue

        recording.destroy!
      end
      
      
    end

    
    CatalogUser.all.each do |catalog_user|
      catalog           =  catalog_user.catalog
      account           =  catalog.account
      catalog_owner     =  account.user
      user_id           =  catalog_user.user_id
      manager_ids       =  account.administrator_ids
      manager_ids       << catalog_owner.id
      
      create_recording_ids        = catalog_user.create_recordings            ? [] : [user_id]
        read_recording_ids        =   catalog_user.read_recordings            ? [] : [user_id]
      update_recording_ids        = catalog_user.update_recordings            ? [] : [user_id]
      delete_recording_ids        = catalog_user.delete_recordings            ? [] : [user_id]
                                                                              
      create_recording_ipi_ids    = catalog_user.create_recording_ipis        ? [] : [user_id]
        read_recording_ipi_ids    =   catalog_user.read_recording_ipis        ? [] : [user_id]
      update_recording_ipi_ids    = catalog_user.update_recording_ipis        ? [] : [user_id]
      delete_recording_ipi_ids    = catalog_user.delete_recording_ipis        ? [] : [user_id]
                                                                              
      create_files_ids            = catalog_user.create_files                 ? [] : [user_id]
        read_files_ids            =   catalog_user.read_files                 ? [] : [user_id]
      update_files_ids            = catalog_user.update_files                 ? [] : [user_id]
      delete_files_ids            = catalog_user.delete_files                 ? [] : [user_id]
                                                                            
      create_legal_documents_ids  = catalog_user.create_legal_documents       ? [] : [user_id]
        read_legal_documents_ids  =   catalog_user.read_legal_documents       ? [] : [user_id]
      update_legal_documents_ids  = catalog_user.update_legal_documents       ? [] : [user_id]
      delete_legal_documents_ids  = catalog_user.delete_legal_documents       ? [] : [user_id]
      
      create_legal_financial_ids  = catalog_user.create_financial_documents   ? [] : [user_id]
        read_legal_financial_ids  =   catalog_user.read_financial_documents   ? [] : [user_id]
      update_legal_financial_ids  = catalog_user.update_financial_documents   ? [] : [user_id]
      delete_legal_financial_ids  = catalog_user.delete_financial_documents   ? [] : [user_id]
      

        read_common_works_ids     =   catalog_user.read_common_works           ? [] : [user_id]
      update_common_works_ids     = catalog_user.update_common_works           ? [] : [user_id]

      
      create_common_works_ipi_ids = catalog_user.create_common_work_ipis       ? [] : [user_id]
        read_common_works_ipi_ids =   catalog_user.read_common_work_ipis       ? [] : [user_id]
      update_common_works_ipi_ids = catalog_user.update_common_work_ipis       ? [] : [user_id]
      delete_common_works_ipi_ids = catalog_user.delete_common_work_ipis       ? [] : [user_id]


      if recordings = catalog.recordings
        recordings.each do |recording|
          
          recording.create_recording_ids             = manager_ids + create_recording_ids
          recording.read_recording_ids               = manager_ids +   read_recording_ids
          recording.update_recording_ids             = manager_ids + update_recording_ids
          recording.delete_recording_ids             = manager_ids + delete_recording_ids
          recording.create_recording_ipis_ids        = manager_ids + create_recording_ids
          recording.read_recording_ipis_ids          = manager_ids +   read_recording_ids
          recording.update_recording_ipis_ids        = manager_ids + update_recording_ids
          recording.delete_recording_ipis_ids        = manager_ids + delete_recording_ids
          recording.create_files_ids                 = manager_ids + create_files_ids
          recording.read_files_ids                   = manager_ids +   read_files_ids
          recording.update_files_ids                 = manager_ids + update_files_ids
          recording.delete_files_ids                 = manager_ids + delete_files_ids
          recording.create_legal_documents_ids       = manager_ids + create_legal_documents_ids
          recording.read_legal_documents_ids         = manager_ids +   read_legal_documents_ids
          recording.update_legal_documents_ids       = manager_ids + update_legal_documents_ids
          recording.delete_legal_documents_ids       = manager_ids + delete_legal_documents_ids
          recording.create_financial_documents_ids   = manager_ids + create_legal_financial_ids 
          recording.read_financial_documents_ids     = manager_ids +   read_legal_financial_ids 
          recording.update_financial_documents_ids   = manager_ids + update_legal_financial_ids 
          recording.delete_financial_documents_ids   = manager_ids + delete_legal_financial_ids 
          recording.read_common_works_ids            = manager_ids +   read_common_works_ids
          recording.update_common_works_ids          = manager_ids + update_common_works_ids
          recording.create_common_work_ipis_ids      = manager_ids + create_common_works_ipi_ids
          recording.read_common_work_ipis_ids        = manager_ids +   read_common_works_ipi_ids
          recording.update_common_work_ipis_ids      = manager_ids + update_common_works_ipi_ids
          recording.delete_common_work_ipis_ids      = manager_ids + delete_common_works_ipi_ids
          recording.save!
        end
      end
    end
    
    Recording.all.each do |recording|
      RecordingPermissions.unique_user_ids_for recording
    end
    
  end
  
  def down
    
  end
end


# recorrdings ***************************

# create_recording_ids",           
# read_recording_ids",             
# update_recording_ids",           
# delete_recording_ids",           
# create_recording_ipis_ids",      
# read_recording_ipis_ids",        
# update_recording_ipis_ids",      
# delete_recording_ipis_ids",      
# create_files_ids",               
# read_files_ids",                 
# update_files_ids",               
# delete_files_ids",               
# create_legal_documents_ids",     
# read_legal_documents_ids",       
# update_legal_documents_ids",     
# delete_legal_documents_ids",     
# create_financial_documents_ids", 
# read_financial_documents_ids",   
# update_financial_documents_ids", 
# delete_financial_documents_ids", 
# read_common_works_ids",          
# update_common_works_ids",        
# create_common_work_ipis_ids",    
# read_common_work_ipis_ids",      
# update_common_work_ipis_ids",    
# delete_common_work_ipis_ids",    

# catalog users ******************************************
        
# create_recordings",          
# read_recordings",            
# update_recordings",          
# delete_recordings",          
# create_recording_ipis",      
# read_recording_ipis",        
# update_recording_ipis",      
# delete_recording_ipis",      
# create_files",               
# read_files",                 
# update_files",               
# delete_files",               
# create_legal_documents",     
# read_legal_documents",       
# update_legal_documents",     
# delete_legal_documents",     
# create_financial_documents", 
# read_financial_documents",   
# update_financial_documents", 
# delete_financial_documents", 
# create_common_works",        
# read_common_works",          
# update_common_works",        
# delete_common_works",        
# create_common_work_ipis",    
# read_common_work_ipis",      
# update_common_work_ipis",    
# delete_common_work_ipis",    