class CreateOpportunitiesUsers < ActiveRecord::Migration
  def change
    create_table :opportunities_users do |t|
      t.belongs_to :opportunity, index: true
      t.belongs_to :user, index: true
      t.boolean :invited, default: false
      t.timestamps
    end
  end
end
