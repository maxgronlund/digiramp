class CreateRepresentativeSplits < ActiveRecord::Migration
  def change
    create_table :representative_splits do |t|
      t.integer :work_split
      t.integer :recording_split
      t.belongs_to :account, index: true, foreign_key: true
      t.belongs_to :common_work, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
