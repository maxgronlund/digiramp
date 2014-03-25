class MergeRecordingCommentWithDescription < ActiveRecord::Migration
  def change
    
    Recording.all.each do |recording|
      if( (recording.description.to_s == '') && (!recording.comment.to_s == ''))
        recording.description = recording.comment
        recording.save!
      end
    end
    remove_column :recordings, :comment
    rename_column :recordings, :description, :comment
    
    
    Recording.all.each do |recording|
      if( (recording.artists.to_s == '') && (!recording.artist.to_s == ''))
        recording.artists = recording.artist
        recording.save!
      end
    end
    remove_column :recordings, :artist
    rename_column :recordings, :artists, :artist
    
  end
end
