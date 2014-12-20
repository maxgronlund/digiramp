class CreateSelectedOpportunities < ActiveRecord::Migration
  def change
    create_table :selected_opportunities do |t|
      t.belongs_to :user, index: true
      t.belongs_to :opportunity, index: true

      t.timestamps
    end
    
    drop_table :opportunities_users
  end
end
