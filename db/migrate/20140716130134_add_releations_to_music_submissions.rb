class AddReleationsToMusicSubmissions < ActiveRecord::Migration
  def change
    drop_table :submissions
    add_column :music_submissions, :stars, :integer, default: 0
    add_column :music_submissions, :like, :integer, default: 0
  end
end
