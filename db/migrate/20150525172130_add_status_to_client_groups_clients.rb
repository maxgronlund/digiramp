class AddStatusToClientGroupsClients < ActiveRecord::Migration
  def change
    add_column :client_invitations, :sendgrid_status, :integer     , default: 0
    add_column :client_invitations, :sendgrid_msg, :string, default: ''
    add_column :client_invitations, :email, :string, default: ''
    
    ClientInvitation.find_each do |client_invitation|
      if client = client_invitation.client
        client_invitation.email = client.email
        client_invitation.save
      else
        client_invitation.destroy
      end
    end
    ClientInvitation.update_all(status: 0)
  end
end
