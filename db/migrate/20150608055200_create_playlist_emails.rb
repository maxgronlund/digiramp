class CreatePlaylistEmails < ActiveRecord::Migration
  def change
    create_table :playlist_emails do |t|
      t.text :email_list
      t.string :title
      t.text :body
      t.boolean :attach_files
      t.belongs_to :playlist, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
