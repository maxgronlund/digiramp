class MergeRecordingCommentWithDescription < ActiveRecord::Migration
  def change
    
    Recording.all.each do |recording|
      if recording.description.empty? && !recording.comment.empty?
        recording.description = recording.comment
        recording.save!
      end
    end
    remove_column :recordings, :comment
    rename_column :recordings, :description, :comment
    
    
    Recording.all.each do |recording|
      if recording.artists.empty? && !recording.artist.empty?
        recording.artists = recording.artist
        recording.save!
      end
    end
    remove_column :recordings, :artist
    rename_column :recordings, :artists, :artist
    
  end
end
