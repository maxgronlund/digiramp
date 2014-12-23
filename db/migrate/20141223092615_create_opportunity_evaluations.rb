class CreateOpportunityEvaluations < ActiveRecord::Migration
  def change
    add_column :opportunities, :uuid, :string
    
    Opportunity.find_each do |opportunity|
      opportunity.uuid = UUIDTools::UUID.timestamp_create().to_s
      opportunity.save
    end
    
    
    
    create_table :opportunity_evaluations do |t|
      t.belongs_to :opportunity, index: true
      t.belongs_to :user, index: true
      t.string :uuid
      t.string :email

      t.timestamps
    end
  end
end
