class RecordingPermissions
  
  def initialize
  end
  
  
  #RecordingPermissions.create_catalog_user_permissions catalog, catalog_user
  def self.create_catalog_user_permissions catalog, catalog_user
    
    if catalog.recordings
      user_id           =  catalog_user.user_id

      catalog.recordings.each do |recording|
        recording.create_recording_ids             <<  user_id  if catalog_user.create_recordings           
        recording.read_recording_ids               <<  user_id  if catalog_user.read_recordings             
        recording.update_recording_ids             <<  user_id  if catalog_user.update_recordings           
        recording.delete_recording_ids             <<  user_id  if catalog_user.delete_recordings           
        recording.create_recording_ipis_ids        <<  user_id  if catalog_user.create_recording_ipis       
        recording.read_recording_ipis_ids          <<  user_id  if catalog_user.read_recording_ipis         
        recording.update_recording_ipis_ids        <<  user_id  if catalog_user.update_recording_ipis       
        recording.delete_recording_ipis_ids        <<  user_id  if catalog_user.delete_recording_ipis       
        recording.create_files_ids                 <<  user_id  if catalog_user.create_files                
        recording.read_files_ids                   <<  user_id  if catalog_user.read_files                  
        recording.update_files_ids                 <<  user_id  if catalog_user.update_files                
        recording.delete_files_ids                 <<  user_id  if catalog_user.delete_files                
        recording.create_legal_documents_ids       <<  user_id  if catalog_user.create_legal_documents      
        recording.read_legal_documents_ids         <<  user_id  if catalog_user.read_legal_documents        
        recording.update_legal_documents_ids       <<  user_id  if catalog_user.update_legal_documents      
        recording.delete_legal_documents_ids       <<  user_id  if catalog_user.delete_legal_documents      
        recording.create_financial_documents_ids   <<  user_id  if catalog_user.create_financial_documents  
        recording.read_financial_documents_ids     <<  user_id  if catalog_user.read_financial_documents    
        recording.update_financial_documents_ids   <<  user_id  if catalog_user.update_financial_documents  
        recording.delete_financial_documents_ids   <<  user_id  if catalog_user.delete_financial_documents  
        recording.read_common_works_ids            <<  user_id  if catalog_user.read_common_works         
        recording.update_common_works_ids          <<  user_id  if catalog_user.update_common_works           
        recording.create_common_work_ipis_ids      <<  user_id  if catalog_user.create_common_work_ipis        
        recording.read_common_work_ipis_ids        <<  user_id  if catalog_user.read_common_work_ipis          
        recording.update_common_work_ipis_ids      <<  user_id  if catalog_user.update_common_work_ipis     
        recording.delete_common_work_ipis_ids      <<  user_id  if catalog_user.delete_common_work_ipis       
        recording.save!
        
      end
    end
  end
  
  def self.update_catalog_user_permissions catalog, catalog_user
    
    if catalog.recordings
      user_id           =  catalog_user.user_id
      delete_catalog_user_permissions catalog, catalog_user

      catalog.recordings.each do |recording|
        recording.create_recording_ids             <<  user_id  if catalog_user.create_recordings           
        recording.read_recording_ids               <<  user_id  if catalog_user.read_recordings             
        recording.update_recording_ids             <<  user_id  if catalog_user.update_recordings           
        recording.delete_recording_ids             <<  user_id  if catalog_user.delete_recordings           
        recording.create_recording_ipis_ids        <<  user_id  if catalog_user.create_recording_ipis       
        recording.read_recording_ipis_ids          <<  user_id  if catalog_user.read_recording_ipis         
        recording.update_recording_ipis_ids        <<  user_id  if catalog_user.update_recording_ipis       
        recording.delete_recording_ipis_ids        <<  user_id  if catalog_user.delete_recording_ipis       
        recording.create_files_ids                 <<  user_id  if catalog_user.create_files                
        recording.read_files_ids                   <<  user_id  if catalog_user.read_files                  
        recording.update_files_ids                 <<  user_id  if catalog_user.update_files                
        recording.delete_files_ids                 <<  user_id  if catalog_user.delete_files                
        recording.create_legal_documents_ids       <<  user_id  if catalog_user.create_legal_documents      
        recording.read_legal_documents_ids         <<  user_id  if catalog_user.read_legal_documents        
        recording.update_legal_documents_ids       <<  user_id  if catalog_user.update_legal_documents      
        recording.delete_legal_documents_ids       <<  user_id  if catalog_user.delete_legal_documents      
        recording.create_financial_documents_ids   <<  user_id  if catalog_user.create_financial_documents  
        recording.read_financial_documents_ids     <<  user_id  if catalog_user.read_financial_documents    
        recording.update_financial_documents_ids   <<  user_id  if catalog_user.update_financial_documents  
        recording.delete_financial_documents_ids   <<  user_id  if catalog_user.delete_financial_documents  
        recording.read_common_works_ids            <<  user_id  if catalog_user.read_common_works         
        recording.update_common_works_ids          <<  user_id  if catalog_user.update_common_works           
        recording.create_common_work_ipis_ids      <<  user_id  if catalog_user.create_common_work_ipis        
        recording.read_common_work_ipis_ids        <<  user_id  if catalog_user.read_common_work_ipis          
        recording.update_common_work_ipis_ids      <<  user_id  if catalog_user.update_common_work_ipis     
        recording.delete_common_work_ipis_ids      <<  user_id  if catalog_user.delete_common_work_ipis       
        recording.save!
        
      end
    end
  end
  
  def self.delete_catalog_user_permissions catalog, catalog_user
    
    if catalog.recordings
      user_id           =  catalog_user.user_id

      catalog.recordings.each do |recording|
        recording.create_recording_ids             -=  [user_id]    
        recording.read_recording_ids               -=  [user_id]    
        recording.update_recording_ids             -=  [user_id]    
        recording.delete_recording_ids             -=  [user_id]    
        recording.create_recording_ipis_ids        -=  [user_id]    
        recording.read_recording_ipis_ids          -=  [user_id]    
        recording.update_recording_ipis_ids        -=  [user_id]    
        recording.delete_recording_ipis_ids        -=  [user_id]    
        recording.create_files_ids                 -=  [user_id]    
        recording.read_files_ids                   -=  [user_id]    
        recording.update_files_ids                 -=  [user_id]    
        recording.delete_files_ids                 -=  [user_id]    
        recording.create_legal_documents_ids       -=  [user_id]    
        recording.read_legal_documents_ids         -=  [user_id]    
        recording.update_legal_documents_ids       -=  [user_id]    
        recording.delete_legal_documents_ids       -=  [user_id]    
        recording.create_financial_documents_ids   -=  [user_id]    
        recording.read_financial_documents_ids     -=  [user_id]    
        recording.update_financial_documents_ids   -=  [user_id]    
        recording.delete_financial_documents_ids   -=  [user_id]    
        recording.read_common_works_ids            -=  [user_id]  
        recording.update_common_works_ids          -=  [user_id]      
        recording.create_common_work_ipis_ids      -=  [user_id]       
        recording.read_common_work_ipis_ids        -=  [user_id]       
        recording.update_common_work_ipis_ids      -=  [user_id]    
        recording.delete_common_work_ipis_ids      -=  [user_id] 
        
        #recording = uniq_user_ids recording     
        recording.save!
      end
    end
  end
  
  def self.unique_user_ids_for recording
    
    recording.create_recording_ids.uniq!       
    recording.read_recording_ids.uniq!         
    recording.update_recording_ids.uniq!       
    recording.delete_recording_ids.uniq!       
    recording.create_recording_ipis_ids.uniq!  
    recording.read_recording_ipis_ids.uniq!    
    recording.update_recording_ipis_ids.uniq!  
    recording.delete_recording_ipis_ids.uniq!  
    recording.create_files_ids.uniq!           
    recording.read_files_ids.uniq!             
    recording.update_files_ids.uniq!           
    recording.delete_files_ids.uniq!           
    recording.create_legal_documents_ids.uniq! 
    recording.read_legal_documents_ids.uniq!   
    recording.update_legal_documents_ids.uniq! 
    recording.delete_legal_documents_ids.uniq! 
    recording.create_financial_documents_ids.uniq!
    recording.read_financial_documents_ids.uniq!
    recording.update_financial_documents_ids.uniq!
    recording.delete_financial_documents_ids.uniq!
    recording.read_common_works_ids.uniq!      
    recording.update_common_works_ids.uniq!    
    recording.create_common_work_ipis_ids.uniq!
    recording.read_common_work_ipis_ids.uniq!  
    recording.update_common_work_ipis_ids.uniq!
    recording.delete_common_work_ipis_ids.uniq!
    recording.save!
  end
  
  
end