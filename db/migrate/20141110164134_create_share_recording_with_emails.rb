class CreateShareRecordingWithEmails < ActiveRecord::Migration
  def change
    create_table :share_recording_with_emails do |t|
      t.belongs_to :user, index: true
      t.belongs_to :recording, index: true
      t.text :recipients
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
