class AddPermissionKeyToRecordings < ActiveRecord::Migration
  def change
    # will fail due to serialazion is removed from the model
    #add_column :recordings, :permission_keys, :text, default: []
    
    #add_column :recordings, :create_recording_ids,           :text, default: []
    #add_column :recordings, :read_recording_ids,             :text, default: []
    #add_column :recordings, :update_recording_ids,           :text, default: []
    #add_column :recordings, :delete_recording_ids,           :text, default: []
    #                                                                  
    #add_column :recordings, :create_recording_ipis_ids,      :text, default: []
    #add_column :recordings, :read_recording_ipis_ids,        :text, default: []
    #add_column :recordings, :update_recording_ipis_ids,      :text, default: []
    #add_column :recordings, :delete_recording_ipis_ids,      :text, default: []
    #                                                                       
    #add_column :recordings, :create_files_ids,               :text, default: []
    #add_column :recordings, :read_files_ids,                 :text, default: []
    #add_column :recordings, :update_files_ids,               :text, default: []
    #add_column :recordings, :delete_files_ids,               :text, default: []
    #                                                                       
    #add_column :recordings, :create_legal_documents_ids,     :text, default: []
    #add_column :recordings, :read_legal_documents_ids,       :text, default: []
    #add_column :recordings, :update_legal_documents_ids,     :text, default: []
    #add_column :recordings, :delete_legal_documents_ids,     :text, default: []
    #                                                                       
    #add_column :recordings, :create_financial_documents_ids, :text, default: []
    #add_column :recordings, :read_financial_documents_ids,   :text, default: []
    #add_column :recordings, :update_financial_documents_ids, :text, default: []
    #add_column :recordings, :delete_financial_documents_ids, :text, default: []
    #                                                                       
    #
    #add_column :recordings, :read_common_works_ids,          :text, default: []
    #add_column :recordings, :update_common_works_ids,        :text, default: []
    #
    #                                                                       
    #add_column :recordings, :create_common_work_ipis_ids,    :text, default: []
    #add_column :recordings, :read_common_work_ipis_ids,      :text, default: []
    #add_column :recordings, :update_common_work_ipis_ids,    :text, default: []
    #add_column :recordings, :delete_common_work_ipis_ids,    :text, default: []
    
    
  end
end
