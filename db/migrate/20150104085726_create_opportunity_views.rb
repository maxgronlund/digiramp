class CreateOpportunityViews < ActiveRecord::Migration
  def change
    create_table :opportunity_views do |t|
      t.belongs_to :user, index: true
      t.belongs_to :opportunity, index: true

      t.timestamps
    end
    
    
  end
end
