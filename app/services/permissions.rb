class Permissions
  
  TYPES = [  "create_recording",          
             "read_recording",             
             "update_recording",           
             "delete_recording",                  
             
             "create_recording_ipi",      
             "read_recording_ipi",        
             "update_recording_ipi",      
             "delete_recording_ipi",        
             
             "create_file",               
             "read_file",                 
             "update_file",               
             "delete_file",             
             
             "create_legal_document",     
             "read_legal_document",       
             "update_legal_document",     
             "delete_legal_document",      
             
             "create_financial_document", 
             "read_financial_document",   
             "update_financial_document", 
             "delete_financial_document", 
             
             "create_common_work", 
             "read_common_work",          
             "update_common_work",       
             "delete_common_work",         
             
             "create_common_work_ipi", 
             "read_common_work_ipi", 
             "update_common_work_ipi",   
             "delete_common_work_ipi",         
             
             "create_account_user", 
               "read_account_user", 
             "update_account_user",   
             "delete_account_user",         
             
             "create_catalog", 
               "read_catalog", 
             "update_catalog",   
             "delete_catalog",         
             
             "create_playlist", 
               "read_playlist", 
             "update_playlist",   
             "delete_playlist",         
             
             "create_crm", 
               "read_crm", 
             "update_crm",   
             "delete_crm"
            ]
  
  def initialize
  end
  

  
  #def self.can_access_private_account account, current_user
  #  # pessimistic locking
  #  access = false
  #  
  #  if current_user
  #  # no access for users not signed in 
  #    if current_user.id == account.user_id
  #       # all users have access to their own account
  #      access =  true
  #    else current_user.super?
  #      # super user can access all private accounts
  #      access =  true
  #    end
  #  end
  #  access
  #end
  
end

