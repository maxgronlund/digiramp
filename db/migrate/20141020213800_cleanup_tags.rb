class CleanupTags < ActiveRecord::Migration
  def change
    add_column :instruments, :recordings_count, :integer, default: 0
    add_column :moods, :recordings_count, :integer, default: 0
    
    GenreTag.where(genre_tagable_id: nil).destroy_all
    InstrumentTag.where(instrument_tagable_id: nil).destroy_all
    MoodTag.where(mood_tagable_id: nil).destroy_all
    
    # clean up Genre
    Genre.find_each do |genre|
      genre.genre_tags.find_each do |genre_tag|
        case genre_tag.genre_tagable_type
        when 'Recording'
          unless Recording.exists?(genre_tag.genre_tagable_id)
            genre_tag.destroy
          end
        end
      end
      genre.reset_count
    end
    
  end
end
