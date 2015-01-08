class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.text :body
      t.string :image
      t.belongs_to :user, index: true
      t.boolean :public_forum

      t.timestamps
    end
  end
end
