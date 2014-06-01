class AddInvitationTitleToAccountUsers < ActiveRecord::Migration
  def change
    add_column :account_users, :invitation_title, :string
  end
end
