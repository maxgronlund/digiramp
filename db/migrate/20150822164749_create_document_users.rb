class CreateDocumentUsers < ActiveRecord::Migration
  def change
    drop_table :document_users
    
    create_table :document_users, id: :uuid do |t|
      t.uuid :document_id
      t.belongs_to :user, index: true, foreign_key: false
      t.belongs_to :account, index: true, foreign_key: false
      t.boolean :can_edit
      t.boolean :should_sign
      t.string :email
      t.string :signature
      t.string :signature_image
      t.integer :status

      t.timestamps null: false
    end
    
    add_index :document_users, :document_id
  end
end
