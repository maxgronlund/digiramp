class CreateLabelRecordings < ActiveRecord::Migration
  def change
    create_table :label_recordings do |t|
      t.belongs_to :label, index: true, foreign_key: false
      t.belongs_to :recording, index: true, foreign_key: false

      t.timestamps null: false
    end
    
    add_foreign_key "label_recordings", "labels", on_delete: :cascade
    add_foreign_key "label_recordings", "recordings",    on_delete: :cascade
  end
end
