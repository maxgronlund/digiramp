class AddUuidToClientInvitations < ActiveRecord::Migration
  def change
    add_column :client_invitations, :uuid, :string
    
  end
end
