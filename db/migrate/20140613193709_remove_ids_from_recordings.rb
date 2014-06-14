class RemoveIdsFromRecordings < ActiveRecord::Migration
  def up
    remove_column :recordings, :create_recording_ids
    remove_column :recordings, :read_recording_ids
    remove_column :recordings, :update_recording_ids
    remove_column :recordings, :delete_recording_ids
    remove_column :recordings, :create_recording_ipi_ids
    remove_column :recordings, :read_recording_ipi_ids
    remove_column :recordings, :update_recording_ipi_ids
    remove_column :recordings, :delete_recording_ipi_ids
    remove_column :recordings, :create_file_ids
    remove_column :recordings, :read_file_ids
    remove_column :recordings, :update_file_ids
    remove_column :recordings, :delete_file_ids
    remove_column :recordings, :create_legal_document_ids
    remove_column :recordings, :read_legal_document_ids
    remove_column :recordings, :update_legal_document_ids      
    remove_column :recordings, :delete_legal_document_ids      
    remove_column :recordings, :create_financial_document_ids  
    remove_column :recordings, :read_financial_document_ids    
    remove_column :recordings, :update_financial_document_ids  
    remove_column :recordings, :delete_financial_document_ids  
    remove_column :recordings, :read_common_work_ids           
    remove_column :recordings, :update_common_work_ids         
    remove_column :recordings, :create_common_work_ipi_ids     
    remove_column :recordings, :read_common_work_ipi_ids       
    remove_column :recordings, :update_common_work_ipi_ids     
    remove_column :recordings, :delete_common_work_ipi_ids     
  end
  
  def down
    
  end
end
