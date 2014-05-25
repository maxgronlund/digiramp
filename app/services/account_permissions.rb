# to do, let parmissions go true to the recordings






class AccountPermissions
  
  
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
                        
                        "create_common_work_ids", 
                        "read_common_work_ids",          
                        "update_common_work_ids",       
                        "delete_common_work_ids",         
                        
                        "create_common_work_ipi_ids", 
                        "read_common_work_ipi_ids", 
                        "update_common_work_ipi_ids",   
                        "delete_common_work_ipi_ids",         
                        
                        "create_account_user_ids", 
                          "read_account_user_ids", 
                        "update_account_user_ids",   
                        "delete_account_user_ids",         
                        
                        "create_catalog_ids", 
                          "read_catalog_ids", 
                        "update_catalog_ids",   
                        "delete_catalog_ids",         
                        
                        "create_playlist_ids", 
                          "read_playlist_ids", 
                        "update_playlist_ids",   
                        "delete_playlist_ids",         
                        
                        "create_crm_ids", 
                          "read_crm_ids", 
                        "update_crm_ids",   
                        "delete_crm_ids"
                      ]
  
  def initialize
  end
  
  #AccountPermissions.add_user  user_id, account
  # Create permissions
  def self.add_user account_user, account
    
    user_id = account_user.user_id
    
    account.permitted_user_ids += [user_id]
    
    #  permissions 
    PERMISSION_TYPES.each do |permission_type|
      permission = permission_type.gsub('_ids', '')
      if eval "account_user.#{permission}"
        eval "account.#{permission_type}  += #{[user_id]}" 
      end
    end
    unique_user_ids account
    account.save!
    set_access_for account_user
  end
  
  # update
  # AccountPermissions.update_user account_user, account
  def self.update_user account_user, account
    
    # remove old permissions
    delete_user account_user.user_id, account
    
    # add new permissions
    add_user account_user, account
    
    # remove dublicats
    unique_user_ids account
    
    # save and get a new uuid
    account.save!

  end
  
  # delete
  def self.delete_user user_id, account
    account.permitted_user_ids -= [user_id]
    PERMISSION_TYPES.each do |permission_type|
      eval "account.#{permission_type}  -= [#{user_id}]"  
    end
    account.save!
  end
  
  
  #AccountPermissions.grand_all_permissions user_id, account
  # grand all permissions 
  def self.grand_all_permissions account_user
    # add user_id to the access
    account.permitted_user_ids   += [ account_user.user_id ]
    
    # add the given permissions
    PERMISSION_TYPES.each do |permission_type|
      eval "account.#{permission_type} += #{[account_user.user_id]}"
    end
    # remove dublicate users
    unique_user_ids account_user.account
    account.save!

  end
  
  # remove dublicats
  def self.unique_user_ids account
    
    account.permitted_user_ids.uniq!
    PERMISSION_TYPES.each do |permission_type|
      eval "account.#{permission_type}.uniq!"
    end
  end
  
private

  

  # short cut to se if an account_user has acces to an account
  def self.set_access_for account_user
    user_can_access_account = false
    PERMISSION_TYPES.each do |permission_type|
      if eval "account_user.#{permission_type.gsub('_ids', '') }"
        user_can_access_account = true
        break
      end
    end
    # update the white list
    update_white_list account_user.account, account_user.user_id, user_can_access_account
  end
  
  # white list users with account access
  def self.update_white_list account, user_id, user_can_access_account
    
    if user_can_access_account
      # add user to white list
      account.permitted_user_ids += [user_id]
      # remove dublicats
      account.permitted_user_ids.uniq!
    else
      # remove user from white list
      account.permitted_user_ids -= [user_id]
    end
  end

end