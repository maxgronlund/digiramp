class CreateRecordingUsers < ActiveRecord::Migration
  def change
    create_table :recording_users do |t|
      t.belongs_to :user, index: true, foreign_key: false
      t.belongs_to :recording, index: true, foreign_key: false
      t.string :email

      t.timestamps null: false
    end
    add_foreign_key :recording_users, :recordings, on_delete: :cascade
  end
end
