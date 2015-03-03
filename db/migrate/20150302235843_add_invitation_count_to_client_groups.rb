class AddInvitationCountToClientGroups < ActiveRecord::Migration
  def change
    add_column :client_groups, :invitation_count, :integer
    
    ClientGroup.find_each do |client_group|
      client_group.invitation_count = client_group.invited ? 1 : 0
      client_group.save!
    end
  end
end
