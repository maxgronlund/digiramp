class AddProviderToOpportunityUsers < ActiveRecord::Migration
  def change
    add_column :opportunity_users, :provider, :bool, default: true
    add_column :opportunity_users, :reviewer, :bool, default: false
    

    add_column :opportunity_invitations, :provider, :bool, default: true
    add_column :opportunity_invitations, :reviewer, :bool, default: false
    
    OpportunityUser.update_all(provider: true, reviewer: false)
  end
end
