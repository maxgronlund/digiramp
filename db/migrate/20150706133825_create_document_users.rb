class CreateDocumentUsers < ActiveRecord::Migration
  def change
    create_table :document_users do |t|
      t.belongs_to :document, index: true
      t.references :user, polymorphic: true, index: true

      t.timestamps null: false
    end
    
    add_foreign_key     :document_users,      :documents     , on_delete: :cascade

  end
end
