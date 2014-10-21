class AddRecordingsCountToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :recordings_count, :integer, default: 0
    
    Genre.find_each do |genre|
      genre.recordings_count = genre.genre_tags.count
      genre.save!
    end
  end
end
