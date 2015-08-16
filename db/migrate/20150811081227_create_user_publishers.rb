class CreateUserPublishers < ActiveRecord::Migration
  def change
    create_table :user_publishers do |t|
      t.belongs_to :publisher, index: true, foreign_key: false
      t.integer :legal_document_id
      t.text :notes
      t.timestamps null: false
    end
    add_foreign_key :user_publishers, :publishers, on_delete: :cascade
    
  end
end
