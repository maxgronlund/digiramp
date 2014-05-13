class CreateComments < ActiveRecord::Migration
  def change
    drop_table :comments
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.belongs_to :user, index: true
      t.belongs_to :commentable, polymorphic: true
      t.string :image

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
