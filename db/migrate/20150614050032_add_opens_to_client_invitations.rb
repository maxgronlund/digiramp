class AddOpensToClientInvitations < ActiveRecord::Migration
  def change
    add_column :client_invitations, :opens, :integer,   default: 0 
    add_column :client_invitations, :clicks, :integer,    default: 0
    add_column :messages, :opens, :integer,   default: 0
    add_column :messages, :clicks, :integer,    default: 0
  end
end
