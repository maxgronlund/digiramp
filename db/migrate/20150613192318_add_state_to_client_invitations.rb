class AddStateToClientInvitations < ActiveRecord::Migration
  def change
    add_column :client_invitations, :state, :integer, default: 0
  end
end
