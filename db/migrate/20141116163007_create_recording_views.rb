class CreateRecordingViews < ActiveRecord::Migration
  def change
    create_table :recording_views do |t|
      t.belongs_to :user, index: true
      t.belongs_to :recording, index: true
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
