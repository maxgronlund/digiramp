class AddMandrillIdToClientInvitations < ActiveRecord::Migration
  def change
    add_column :client_invitations, :mandrill_id, :string
    add_column :messages, :mandrill_id, :string
  end
end
