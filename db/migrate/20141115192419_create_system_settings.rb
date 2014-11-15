class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.integer :recording_artwork_id
      t.integer :user_avatar_id
      t.integer :company_logo_id

      t.timestamps
    end
  end
end
