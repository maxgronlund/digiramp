class CreateOpportunityInvitations < ActiveRecord::Migration
  def change
    create_table :opportunity_invitations do |t|
      t.belongs_to :opportunity, index: true
      t.string :title
      t.text :body
      t.text :invitees

      t.timestamps
    end
  end
end
