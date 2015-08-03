class AddCanDownloadToOpportunityUsers < ActiveRecord::Migration
  def change
    add_column :opportunity_users, :can_download, :boolean, default: true
    add_column :opportunity_invitations, :can_download, :boolean, default: true
    
    OpportunityUser.update_all(can_download: true)
  end
end
