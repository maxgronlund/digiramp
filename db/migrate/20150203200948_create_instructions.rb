class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.string :title
      t.text :body
      t.string :video
      t.integer :views
      t.string :tag
      t.integer :position
      t.string :link

      t.timestamps
    end
  end
end
