class CreateOpportunityUsers < ActiveRecord::Migration
  def change
    create_table :opportunity_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :opportunity, index: true

      t.timestamps
    end
  end
end
