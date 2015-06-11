class AddClientGroupRefToClientInvitations < ActiveRecord::Migration
  def change
    add_reference :client_invitations, :client_group, index: true, foreign_key: true
    
    ClientGroup.find_each do |client_group|
      client_ids = client_group.client_ids
      if invitations = ClientInvitation.where(user_id: client_group.user_id, client_id: client_ids)
        invitations.update_all(client_group_id: client_group.id)
      end
    end
  end
end
