class AddAccessPermissionsToAccounts < ActiveRecord::Migration
  def change
     
    # permissions for an account user, can be used for restore permissions
    add_column :account_users, :create_recording              , :boolean, default: false
    add_column :account_users, :read_recording                , :boolean, default: false
    add_column :account_users, :update_recording              , :boolean, default: false
    add_column :account_users, :delete_recording              , :boolean, default: false
    
    add_column :account_users, :create_recording_ipi          , :boolean, default: false
    add_column :account_users, :read_recording_ipi            , :boolean, default: false
    add_column :account_users, :update_recording_ipi          , :boolean, default: false
    add_column :account_users, :delete_recording_ipi          , :boolean, default: false
    
    add_column :account_users, :create_file                   , :boolean, default: false
    add_column :account_users, :read_file                     , :boolean, default: false
    add_column :account_users, :update_file                   , :boolean, default: false
    add_column :account_users, :delete_file                   , :boolean, default: false
    
    add_column :account_users, :create_legal_document         , :boolean, default: false
    add_column :account_users, :read_legal_document           , :boolean, default: false
    add_column :account_users, :update_legal_document         , :boolean, default: false
    add_column :account_users, :delete_legal_document         , :boolean, default: false
    
    add_column :account_users, :create_financial_document     , :boolean, default: false
    add_column :account_users, :read_financial_document       , :boolean, default: false
    add_column :account_users, :update_financial_document     , :boolean, default: false
    add_column :account_users, :delete_financial_document     , :boolean, default: false
    
    add_column :account_users, :create_common_work            , :boolean, default: false
    add_column :account_users, :read_common_work              , :boolean, default: false
    add_column :account_users, :update_common_work            , :boolean, default: false
    add_column :account_users, :delete_common_work            , :boolean, default: false
    
    add_column :account_users, :create_common_work_ipi        , :boolean, default: false
    add_column :account_users, :read_common_work_ipi          , :boolean, default: false
    add_column :account_users, :update_common_work_ipi        , :boolean, default: false
    add_column :account_users, :delete_common_work_ipi        , :boolean, default: false
    
    add_column :account_users, :create_account_user           , :boolean, default: false
    add_column :account_users,   :read_account_user           , :boolean, default: false
    add_column :account_users, :update_account_user           , :boolean, default: false
    add_column :account_users, :delete_account_user           , :boolean, default: false
                                                              
    add_column :account_users, :create_catalog                , :boolean, default: false
    add_column :account_users,   :read_catalog                , :boolean, default: false
    add_column :account_users, :update_catalog                , :boolean, default: false
    add_column :account_users, :delete_catalog                , :boolean, default: false
    
    add_column :account_users, :create_playlist               , :boolean, default: false
    add_column :account_users,   :read_playlist               , :boolean, default: false
    add_column :account_users, :update_playlist               , :boolean, default: false
    add_column :account_users, :delete_playlist               , :boolean, default: false
    
    add_column :account_users, :create_crm                    , :boolean, default: false
    add_column :account_users,   :read_crm                    , :boolean, default: false
    add_column :account_users, :update_crm                    , :boolean, default: false
    add_column :account_users, :delete_crm                    , :boolean, default: false
    
    
    # used for easy access to the different permissions
    add_column :accounts, :permitted_user_ids,            :text, default: []
    
    add_column :accounts, :create_recording_ids,          :text, default: []
    add_column :accounts, :read_recording_ids,            :text, default: []
    add_column :accounts, :update_recording_ids,          :text, default: []
    add_column :accounts, :delete_recording_ids,          :text, default: []
                                                                      
    add_column :accounts, :create_recording_ipi_ids,      :text, default: []
    add_column :accounts, :read_recording_ipi_ids,        :text, default: []
    add_column :accounts, :update_recording_ipi_ids,      :text, default: []
    add_column :accounts, :delete_recording_ipi_ids,      :text, default: []
                                                                           
    add_column :accounts, :create_file_ids,               :text, default: []
    add_column :accounts, :read_file_ids,                 :text, default: []
    add_column :accounts, :update_file_ids,               :text, default: []
    add_column :accounts, :delete_file_ids,               :text, default: []
                                                                           
    add_column :accounts, :create_legal_document_ids,     :text, default: []
    add_column :accounts, :read_legal_document_ids,       :text, default: []
    add_column :accounts, :update_legal_document_ids,     :text, default: []
    add_column :accounts, :delete_legal_document_ids,     :text, default: []
                                                                           
    add_column :accounts, :create_financial_document_ids, :text, default: []
    add_column :accounts, :read_financial_document_ids,   :text, default: []
    add_column :accounts, :update_financial_document_ids, :text, default: []
    add_column :accounts, :delete_financial_document_ids, :text, default: []
                                                                           
    add_column :accounts, :create_common_work_ids,        :text, default: []
    add_column :accounts, :read_common_work_ids,          :text, default: []
    add_column :accounts, :update_common_work_ids,        :text, default: []
    add_column :accounts, :delete_common_work_ids,        :text, default: []
    
    add_column :accounts, :create_common_work_ipi_ids,    :text, default: []
    add_column :accounts,   :read_common_work_ipi_ids,    :text, default: []
    add_column :accounts, :update_common_work_ipi_ids,    :text, default: []
    add_column :accounts, :delete_common_work_ipi_ids,    :text, default: []
    
    add_column :accounts, :create_account_user_ids,    :text, default: []
    add_column :accounts,   :read_account_user_ids,    :text, default: []
    add_column :accounts, :update_account_user_ids,    :text, default: []
    add_column :accounts, :delete_account_user_ids,    :text, default: []
    
    add_column :accounts, :create_catalog_ids,    :text, default: []
    add_column :accounts,   :read_catalog_ids,    :text, default: []
    add_column :accounts, :update_catalog_ids,    :text, default: []
    add_column :accounts, :delete_catalog_ids,    :text, default: []
    
    add_column :accounts, :create_playlist_ids,    :text, default: []
    add_column :accounts,   :read_playlist_ids,    :text, default: []
    add_column :accounts, :update_playlist_ids,    :text, default: []
    add_column :accounts, :delete_playlist_ids,    :text, default: []
    
    add_column :accounts, :create_crm_ids,    :text, default: []
    add_column :accounts,   :read_crm_ids,    :text, default: []
    add_column :accounts, :update_crm_ids,    :text, default: []
    add_column :accounts, :delete_crm_ids,    :text, default: []
    
    
    
    
    
  end
end
