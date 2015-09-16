class CreateLabelWorks < ActiveRecord::Migration
  def change
    create_table :label_works do |t|
      t.integer :royalty
      t.belongs_to :label, index: true, foreign_key: false
      t.belongs_to :common_work, index: true, foreign_key: false

      t.timestamps null: false
    end
    
    add_foreign_key "label_works", "labels", on_delete: :cascade
    add_foreign_key "label_works", "common_works",    on_delete: :cascade
  end
end
