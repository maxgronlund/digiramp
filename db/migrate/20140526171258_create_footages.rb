class CreateFootages < ActiveRecord::Migration
  def change
    create_table :footages do |t|
      t.string :title
      t.text :body
      t.text :transloadet
      t.string :thumb
      t.string :uuid
      t.string :mp4_file
      t.string :webm_file
      t.string :copyright
      t.belongs_to :account, index: true
      t.belongs_to :footageable, polymorphic: true
      
      t.timestamps
    end
    add_index :footages, [:footageable_id, :footageable_type]
  end
end
