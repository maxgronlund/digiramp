class AddUuidToOpportunityUsers < ActiveRecord::Migration
  def change
    add_column :opportunity_users, :uuid, :string, default: ''
    
    OpportunityUser.find_each do |opportunity_user|
      opportunity_user.uuid = UUIDTools::UUID.timestamp_create().to_s
      opportunity_user.save!
    end
  end
end
