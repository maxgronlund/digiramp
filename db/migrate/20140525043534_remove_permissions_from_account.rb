class RemovePermissionsFromAccount < ActiveRecord::Migration
  def up
    
    remove_column :accounts, :create_recording_ids
    remove_column :accounts, :read_recording_ids
    remove_column :accounts, :update_recording_ids
    remove_column :accounts, :delete_recording_ids
    remove_column :accounts, :create_recording_ipi_ids
    remove_column :accounts, :read_recording_ipi_ids
    remove_column :accounts, :update_recording_ipi_ids
    remove_column :accounts, :delete_recording_ipi_ids
    remove_column :accounts, :create_file_ids
    remove_column :accounts, :read_file_ids
    remove_column :accounts, :update_file_ids
    remove_column :accounts, :delete_file_ids
    remove_column :accounts, :create_legal_document_ids       
    remove_column :accounts, :read_legal_document_ids         
    remove_column :accounts, :update_legal_document_ids       
    remove_column :accounts, :delete_legal_document_ids       
    remove_column :accounts, :create_financial_document_ids   
    remove_column :accounts, :read_financial_document_ids     
    remove_column :accounts, :update_financial_document_ids   
    remove_column :accounts, :delete_financial_document_ids   
    remove_column :accounts, :create_common_work_ids          
    remove_column :accounts, :read_common_work_ids            
    remove_column :accounts, :update_common_work_ids          
    remove_column :accounts, :delete_common_work_ids          
    remove_column :accounts, :create_common_work_ipi_ids      
    remove_column :accounts, :read_common_work_ipi_ids        
    remove_column :accounts, :update_common_work_ipi_ids      
    remove_column :accounts, :delete_common_work_ipi_ids      
    remove_column :accounts, :create_account_user_ids         
    remove_column :accounts, :read_account_user_ids           
    remove_column :accounts, :update_account_user_ids         
    remove_column :accounts, :delete_account_user_ids         
    remove_column :accounts, :create_catalog_ids              
    remove_column :accounts, :read_catalog_ids                
    remove_column :accounts, :update_catalog_ids              
    remove_column :accounts, :delete_catalog_ids              
    remove_column :accounts, :create_playlist_ids             
    remove_column :accounts, :read_playlist_ids               
    remove_column :accounts, :update_playlist_ids             
    remove_column :accounts, :delete_playlist_ids             
    remove_column :accounts, :create_crm_ids                  
    remove_column :accounts, :read_crm_ids                    
    remove_column :accounts, :update_crm_ids                  
    remove_column :accounts, :delete_crm_ids   
  end
  
  def down
    add_column :accounts, :create_recording_ids,           :text,          default: []
    add_column :accounts, :read_recording_ids,             :text,          default: []
    add_column :accounts, :update_recording_ids,           :text,          default: []
    add_column :accounts, :delete_recording_ids,           :text,          default: []
    add_column :accounts, :create_recording_ipi_ids,       :text,          default: []
    add_column :accounts, :read_recording_ipi_ids,         :text,          default: []
    add_column :accounts, :update_recording_ipi_ids,       :text,          default: []
    add_column :accounts, :delete_recording_ipi_ids,       :text,          default: []
    add_column :accounts, :create_file_ids,                :text,          default: []
    add_column :accounts, :read_file_ids,                  :text,          default: []
    add_column :accounts, :update_file_ids,                :text,          default: []
    add_column :accounts, :delete_file_ids,                :text,          default: []
    add_column :accounts, :create_legal_document_ids,      :text,          default: []
    add_column :accounts, :read_legal_document_ids,        :text,          default: []
    add_column :accounts, :update_legal_document_ids,      :text,          default: []
    add_column :accounts, :delete_legal_document_ids,      :text,          default: []
    add_column :accounts, :create_financial_document_ids,  :text,          default: []
    add_column :accounts, :read_financial_document_ids,    :text,          default: []
    add_column :accounts, :update_financial_document_ids,  :text,          default: []
    add_column :accounts, :delete_financial_document_ids,  :text,          default: []
    add_column :accounts, :create_common_work_ids,         :text,          default: []
    add_column :accounts, :read_common_work_ids,           :text,          default: []
    add_column :accounts, :update_common_work_ids,         :text,          default: []
    add_column :accounts, :delete_common_work_ids,         :text,          default: []
    add_column :accounts, :create_common_work_ipi_ids,     :text,          default: []
    add_column :accounts, :read_common_work_ipi_ids,       :text,          default: []
    add_column :accounts, :update_common_work_ipi_ids,     :text,          default: []
    add_column :accounts, :delete_common_work_ipi_ids,     :text,          default: []
    add_column :accounts, :create_account_user_ids,        :text,          default: []
    add_column :accounts, :read_account_user_ids,          :text,          default: []
    add_column :accounts, :update_account_user_ids,        :text,          default: []
    add_column :accounts, :delete_account_user_ids,        :text,          default: []
    add_column :accounts, :create_catalog_ids,             :text,          default: []
    add_column :accounts, :read_catalog_ids,               :text,          default: []
    add_column :accounts, :update_catalog_ids,             :text,          default: []
    add_column :accounts, :delete_catalog_ids,             :text,          default: []
    add_column :accounts, :create_playlist_ids,            :text,          default: []
    add_column :accounts, :read_playlist_ids,              :text,          default: []
    add_column :accounts, :update_playlist_ids,            :text,          default: []
    add_column :accounts, :delete_playlist_ids,            :text,          default: []
    add_column :accounts, :create_crm_ids,                 :text,          default: []
    add_column :accounts, :read_crm_ids,                   :text,          default: []
    add_column :accounts, :update_crm_ids,                 :text,          default: []
    add_column :accounts, :delete_crm_ids,                 :text,          default: []  
  end
end
