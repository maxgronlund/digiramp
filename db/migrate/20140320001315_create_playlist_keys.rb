class CreatePlaylistKeys < ActiveRecord::Migration
  def change
    create_table :playlist_keys do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.boolean :password_protection
      t.string :password
      t.string :page_link
      t.boolean :expires
      t.date :expiration_date

      t.timestamps
    end
  end
end
