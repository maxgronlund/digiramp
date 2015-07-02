class UpdateForeignKeysToAccounts < ActiveRecord::Migration
  def change
    sanitize_clients
    sanitize_common_works_imports
    sanitize_widgets
    sanitize_client_invitations
    sanitize_likes
    
    add_foreign_key     :clients,      :accounts     , on_delete: :cascade
    add_foreign_key     :projects,      :accounts     , on_delete: :cascade
    add_foreign_key     :mail_campaigns,      :accounts     , on_delete: :cascade
    add_foreign_key     :client_groups,      :accounts     , on_delete: :cascade
    add_foreign_key     :client_imports,      :accounts     , on_delete: :cascade
    add_foreign_key     :documents,      :accounts     , on_delete: :cascade
    add_foreign_key     :attachments,      :accounts     , on_delete: :cascade
    add_foreign_key     :common_works_imports,      :accounts     , on_delete: :cascade
    add_foreign_key     :playlists,      :accounts     , on_delete: :cascade
    add_foreign_key     :customer_events,      :accounts     , on_delete: :cascade
    add_foreign_key     :import_batches,      :accounts     , on_delete: :cascade
    add_foreign_key     :catalog_users,      :accounts     , on_delete: :cascade
    add_foreign_key     :account_users,      :accounts     , on_delete: :cascade
    add_foreign_key     :opportunities,      :accounts     , on_delete: :cascade
    add_foreign_key     :playlist_key_users,      :accounts     , on_delete: :cascade
    add_foreign_key     :playbacks,      :accounts     , on_delete: :cascade
    add_foreign_key     :widgets,      :accounts     , on_delete: :cascade
    add_foreign_key     :campaigns,      :accounts     , on_delete: :cascade
    add_foreign_key     :campaign_events,      :accounts     , on_delete: :cascade
    add_foreign_key     :client_invitations,      :accounts     , on_delete: :cascade
    add_foreign_key     :recording_views,      :accounts     , on_delete: :cascade
    add_foreign_key     :likes,      :accounts     , on_delete: :cascade
    remove_foreign_key  :campaigns,      :accounts
    add_foreign_key     :campaigns,      :accounts     , on_delete: :cascade
    remove_foreign_key  :campaign_events,      :accounts
    add_foreign_key     :campaign_events,      :accounts     , on_delete: :cascade
    add_foreign_key     :contracts,      :accounts     , on_delete: :cascade
    add_foreign_key     :creative_projects,      :accounts     , on_delete: :cascade
                        
  end
  
  
  def sanitize_clients
    ap "Client's total: #{Client.count}"
    count = 0
    Client.find_each do |client|
      if client.account.nil?
        count += 1
        client.destroy
      end
    end
    ap "Client's deleted: #{count}"
  end
  
  def sanitize_common_works_imports
    ap "CommonWorksImport's total: #{CommonWorksImport.count}"
    count = 0
    CommonWorksImport.find_each do |common_works_import|
      if common_works_import.account.nil?
        count += 1
        common_works_import.destroy
      end
    end
    ap "CommonWorkImport's deleted: #{count}"
  end
  
  def sanitize_widgets
    ap "Widget's total: #{Widget.count}"
    count = 0
    Widget.find_each do |widget|
      if widget.account.nil?
        count += 1
        widget.destroy
      end
    end
    ap "Widget's deleted: #{count}"
  end
  
  def sanitize_client_invitations
    ap "ClientInvitation's total: #{ClientInvitation.count}"
    count = 0
    ClientInvitation.find_each do |client_invitation|
      if client_invitation.account.nil?
        count += 1
        client_invitation.destroy
      end
    end
    ap "ClientInvitation's deleted: #{count}"
  end
  

  
  def sanitize_likes
    ap "Like's total: #{Like.count}"
    count = 0
    Like.find_each do |like|
      if like.account.nil?
        count += 1
        like.destroy
      end
    end
    ap "Like's deleted: #{count}"
  end
  
  
  
end
