
# remember to remove from account
#t.boolean  "access_to_all_recordings",   default: false
#t.boolean  "access_to_all_common_works", default: false
#t.boolean  "access_to_all_rights",       default: false
#t.boolean  "access_to_all_documents",    default: false
#t.boolean  "access_to_collect",          default: false


class UpdatePermissionsOnAccountUsers < ActiveRecord::Migration
  def up
    
    add_column :accounts, :works_uuid,        :string, default: 'first love 727'
    add_column :accounts, :recordings_uuid,   :string, default: 'first love 727'
    add_column :accounts, :customers_uuid,    :string, default: 'first love 727'
    add_column :accounts, :playlists_uuid,    :string, default: 'first love 727'
    add_column :accounts, :users_uuid,        :string, default: 'first love 727'
    
    #add_column :playlists, :uuid, :string, default: 'novel player'
    add_column :account_users, :uuid, :string, default: 'new bee'
    
    # update legacy data
    AccountUser.all.each do |account_user|
      
      # grand account owner all permissions
      if account_user.role == 'Account Owner' || account_user.role == 'Administrator'
        account_user.access_to_all_recordings     = true
        account_user.access_to_all_common_works   = true
        account_user.access_to_all_documents      = true
        
        account_user.create_catalog               = true
          account_user.read_catalog               = true
        account_user.update_catalog               = true
        account_user.delete_catalog               = true
        
        account_user.create_playlist               = true
          account_user.read_playlist               = true
        account_user.update_playlist               = true
        account_user.delete_playlist               = true
        
        account_user.create_crm               = true
          account_user.read_crm               = true
        account_user.update_crm               = true
        account_user.delete_crm               = true
        
        if account_user.role == 'Account Owner'
          account_user.create_account_user        = true
            account_user.read_account_user        = true
          account_user.update_account_user        = true
          account_user.delete_account_user        = true
        end
        
        account_user.save!
      end
      
      # only grand permissions to Administrators and account owner
      if  account_user.role == 'Associate' || 
          account_user.role == 'Account Owner' || 
          account_user.role == 'Administrator'
        
        if account_user.access_to_all_recordings
          account_user.create_recording                     = true
            account_user.read_recording                     = true
          account_user.update_recording                     = true
          account_user.delete_recording                     = true
          
          account_user.create_recording_ipi                 = true
            account_user.read_recording_ipi                 = true
          account_user.update_recording_ipi                 = true
          account_user.delete_recording_ipi                 = true
        end
        
        
        if account_user.access_to_all_common_works
          account_user.create_common_work                   = true
            account_user.read_common_work                   = true
          account_user.update_common_work                   = true
          account_user.delete_common_work                   = true
          
          account_user.create_common_work_ipi               = true
            account_user.read_common_work_ipi               = true
          account_user.update_common_work_ipi               = true
          account_user.delete_common_work_ipi               = true
        end
        
        if account_user.access_to_all_documents
          account_user.create_file                          = true
            account_user.read_file                          = true
          account_user.update_file                          = true
          account_user.delete_file                          = true
          
          account_user.create_legal_document                = true
            account_user.read_legal_document                = true
          account_user.update_legal_document                = true
          account_user.delete_legal_document                = true
          
          account_user.create_financial_document            = true
            account_user.read_financial_document            = true
          account_user.update_financial_document            = true
          account_user.delete_financial_document            = true
        end
      end

      account_user.save!

    end

    
    # give owners full permission
    Account.all.each do |account|
      
      AccountPermissions.grand_all_permissions account.user_id, account
      
      User.supers.each do |super_man|
        AccountPermissions.grand_all_permissions super_man.id, account
      end
    end
    
    
    
  end
  

  
  def down
    remove_column :accounts, :works_uuid,        :string, default: 'first love 727'
    remove_column :accounts, :recordings_uuid,   :string, default: 'first love 727'
    remove_column :accounts, :customers_uuid,    :string, default: 'first love 727'
    remove_column :accounts, :playlists_uuid,    :string, default: 'first love 727'
    remove_column :accounts, :users_uuid,        :string, default: 'first love 727'
  end
end
