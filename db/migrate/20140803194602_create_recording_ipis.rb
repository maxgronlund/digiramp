class CreateRecordingIpis < ActiveRecord::Migration
  def change
    create_table :recording_ipis do |t|
      t.string :role
      t.string :name
      t.decimal :share
      t.belongs_to :user, index: true
      t.string :user_uuid
      t.belongs_to :recording, index: true

      t.timestamps
    end
  end
end
