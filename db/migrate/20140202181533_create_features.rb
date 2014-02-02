class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :body
      t.integer :video1_id
      t.integer :video2_id
      t.integer :video3_id
      t.integer :video4_id
      t.integer :video5_id

      t.timestamps
    end
  end
end
