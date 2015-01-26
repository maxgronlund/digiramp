class AddInvitedToClientGroups < ActiveRecord::Migration
  def change
    add_column :client_groups, :invited, :boolean, default: false
  end
end
