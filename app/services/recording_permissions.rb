class RecordingPermissions
  
  PERMISSION_TYPES = [  "create_recording_ids",          
                        "read_recording_ids",             
                        "update_recording_ids",           
                        "delete_recording_ids",                  
                        
                        "create_recording_ipi_ids",      
                        "read_recording_ipi_ids",        
                        "update_recording_ipi_ids",      
                        "delete_recording_ipi_ids",        
                        
                        "create_file_ids",               
                        "read_file_ids",                 
                        "update_file_ids",               
                        "delete_file_ids",             
                        
                        "create_legal_document_ids",     
                        "read_legal_document_ids",       
                        "update_legal_document_ids",     
                        "delete_legal_document_ids",      
                        
                        "create_financial_document_ids", 
                        "read_financial_document_ids",   
                        "update_financial_document_ids", 
                        "delete_financial_document_ids", 
                        
                        #"create_common_work_ids", 
                        "read_common_work_ids",          
                        "update_common_work_ids",      
                        #"delete_common_work_ids",         
                        
                        #"create_common_work_ipi_ids", 
                        #"read_common_work_ipi_ids", 
                        #"update_common_work_ipi_ids",   
                        #"delete_common_work_ipi_ids"
                      ]
  
  def initialize
  end
  
  def self.repair_account_permissions account

    # go true all the recordings
    account.recordings.each do |recording|
      add_permissions_to_account_users account.id, recording
    end

  end
  
  # RecordingPermissions.add_accound_user_permissions account
  # this has to more granular including permissions for associated and catalog users
  def self.create_account_permissions recording, account
    account.account_users.each do |account_user|
      #puts account_user.user.email
      add_permissions_to_account_users account.id , account_user
    end

  end

  
  def self.add_permissions_to_account_users account_id, recording
    begin
      # find the account
      account = Account.cached_find(account_id)
      
      # iterate true all users with access to the account
      account.permitted_user_ids.each do |user_id|
        
        # get the account_user
        if account_user = AccountUser.cached_where(account_id, user_id)
          # permit the user to access the recording based on the account user permissions
          add_account_users_permissions recording, account_user
        else
          Rails.logger.debug '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
          Rails.logger.debug '     ERROR 1000' 
          Rails.logger.debug '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
        end
      end
    rescue
      Rails.logger.debug '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
      Rails.logger.debug '     ERROR 1001'
      Rails.logger.debug '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
    end
  end
  
  # RecordingPermissions.update_accound_users_permissions account_user
  # update permissions on all recordings for the user
  def self.update_accound_user_permissions  account_user
    account = account_user.account
    account.recordings.each do |recording|
      
      # first remove permissions
      delete_user_permissions recording, account_user.user_id
      
      # then add permissions 
      add_account_users_permissions recording, account_user
    end
  end
  
  # add the user id to the recordings white_list based on the account_users permissions
  def self.add_account_users_permissions recording, account_user

    #  permissions 
    PERMISSION_TYPES.each do |permission_type|
  
      permission = permission_type.gsub('_ids', '')
      begin
        eval "recording.#{permission_type}  += #{[account_user.user_id]} if account_user.#{permission}" 
      rescue
        puts '+++++++++++++++'
        puts 'error'
        puts '+++++++++++++++'
      end
    end
    unique_user_ids_for recording
    
    #puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    #puts recording.title
    #puts  " _____ _____ _____ _____ _____ _____ _____ "
    #puts  "|   __|  |  |     |     |   __|   __|   __|"
    #puts  "|__   |  |  |   --|   --|   __|__   |__   |"
    #puts  "|_____|_____|_____|_____|_____|_____|_____|"
    #puts ""
    #puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    
    
    
  end
  
  
  
  
  #RecordingPermissions.create_catalog_user_permissions catalog, catalog_user
  def self.create_catalog_user_permissions catalog, catalog_user
    
    if catalog.recordings
      user_id           =  catalog_user.user_id

      catalog.recordings.each do |recording|
        
        PERMISSION_TYPES.each do |permission_type|
          permission = permission_type.gsub('_ids', '')
          eval "recording.#{permission_type}  << #{user_id} if catalog_user.#{permission}" 
        end
        unique_user_ids_for recording
        
      end
    end
  end
  
  def self.update_catalog_user_permissions catalog, catalog_user
    create_catalog_user_permissions catalog, catalog_user
  
  end
  
  def self.delete_catalog_user_permissions catalog, catalog_user
    
    if catalog.recordings
      user_id           =  catalog_user.user_id

      catalog.recordings.each do |recording|
        delete_user_permissions recording, user_id
        
      end
    end
  end
  
  def self.delete_user_permissions recording, user_id
    PERMISSION_TYPES.each do |permission_type|
      permission = permission_type.gsub('_ids', '')
      eval "recording.#{permission_type}  -= #{[user_id]}" 
    end
    recording.save!
  end
  
  def self.unique_user_ids_for recording
    
    PERMISSION_TYPES.each do |permission_type|
      eval "recording.#{permission_type}.uniq!" 
    end
    recording.save!

  end
  
  
  # RecordingPermissions.can_open_common_work recording, user_id  
  def self.can_open_common_work recording, user_id
    
    return true if recording.read_common_work_ids.include?         user_id
    return true if recording.update_common_work_ids.include?       user_id
    return true if recording.create_common_work_ipi_ids.include?   user_id
    return true if recording.read_common_work_ipi_ids.include?     user_id  
    return true if recording.update_common_work_ipi_ids.include?   user_id
    return true if recording.delete_common_work_ipi_ids.include?   user_id
    
    return false
    
  end
  
  
end