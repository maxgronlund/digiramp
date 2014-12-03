class AddSelectedToMusicSubmissions < ActiveRecord::Migration
  def change
    add_column :music_submissions, :selected, :boolean, default: false
  end
end
