class CreateDocuments < ActiveRecord::Migration
  def up
    drop_table :documents
    create_table :documents do |t|
      t.string :title
      t.string :document_type
      t.text :body
      t.string :file
      t.text :transloadit
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
  
  def down
    
  end
end
