class CreatePublishingDeals < ActiveRecord::Migration
  def change
    create_table :publishing_agreements, id: :uuid do |t|
      t.belongs_to :publisher, index: true, foreign_key: false
      t.belongs_to :document, index: true, foreign_key: true
      t.string :title
      t.timestamps null: false
    end
    
    add_foreign_key :publishing_agreements, :publishers, on_delete: :cascade
    
  end
end
