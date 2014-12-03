class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :title
      t.text :body
      t.boolean :recipient_removed
      t.boolean :sender_removed
      t.belongs_to :subjebtable, polymorphic: true
      t.timestamps
    end
    
    add_index :messages, :recipient_id
    add_index :messages, :sender_id
    #add_index :messages, [:recipient_id, :sender_id], unique: true
    add_index :messages, [:subjebtable_id, :subjebtable_type]
    
  end
end
