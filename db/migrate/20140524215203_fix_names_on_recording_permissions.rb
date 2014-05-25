class FixNamesOnRecordingPermissions < ActiveRecord::Migration
  def change

    rename_column :recordings,   :create_recording_ipis_ids,      :create_recording_ipi_ids      
    rename_column :recordings,   :read_recording_ipis_ids,        :read_recording_ipi_ids        
    rename_column :recordings,   :update_recording_ipis_ids,      :update_recording_ipi_ids      
    rename_column :recordings,   :delete_recording_ipis_ids,      :delete_recording_ipi_ids                                                                   
  
    rename_column :recordings,   :create_files_ids,               :create_file_ids               
    rename_column :recordings,   :read_files_ids,                 :read_file_ids                 
    rename_column :recordings,   :update_files_ids,               :update_file_ids               
    rename_column :recordings,   :delete_files_ids,               :delete_file_ids               

    rename_column :recordings,   :create_legal_documents_ids,     :create_legal_document_ids     
    rename_column :recordings,   :read_legal_documents_ids,       :read_legal_document_ids       
    rename_column :recordings,   :update_legal_documents_ids,     :update_legal_document_ids     
    rename_column :recordings,   :delete_legal_documents_ids,     :delete_legal_document_ids                                                                 
  
    rename_column :recordings,   :create_financial_documents_ids, :create_financial_document_ids 
    rename_column :recordings,   :read_financial_documents_ids,   :read_financial_document_ids   
    rename_column :recordings,   :update_financial_documents_ids, :update_financial_document_ids 
    rename_column :recordings,   :delete_financial_documents_ids, :delete_financial_document_ids 

    rename_column :recordings,   :read_common_works_ids,          :read_common_work_ids          
    rename_column :recordings,   :update_common_works_ids,        :update_common_work_ids        
  
    rename_column :recordings,   :create_common_work_ipis_ids,    :create_common_work_ipi_ids    
    rename_column :recordings,   :read_common_work_ipis_ids,      :read_common_work_ipi_ids      
    rename_column :recordings,   :update_common_work_ipis_ids,    :update_common_work_ipi_ids    
    rename_column :recordings,   :delete_common_work_ipis_ids,    :delete_common_work_ipi_ids    

  end
end
