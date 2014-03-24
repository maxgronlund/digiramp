class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :account, index: true
      t.belongs_to :attachable, polymorphic: true
      t.string :file
      t.string :title
      t.string :file_type
      t.text :body
      t.timestamps
    end
    add_index :attachments, [:attachable_id, :attachable_type]
  end
end
