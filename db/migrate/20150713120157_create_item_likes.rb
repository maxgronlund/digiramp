class CreateItemLikes < ActiveRecord::Migration
  def change
    create_table :item_likes do |t|
      t.belongs_to :user, index: true, foreign_key: false
      t.references :like, polymorphic: true, index: true

      t.timestamps null: false
    end
    
    add_foreign_key :item_likes, :users, on_delete: :cascade
  end
end
