class CreateClientInvitations < ActiveRecord::Migration
  def change
    create_table :client_invitations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.belongs_to :client, index: true
      t.string :status

      t.timestamps
    end
  end
end
