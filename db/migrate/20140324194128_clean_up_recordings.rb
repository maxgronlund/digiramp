class CleanUpRecordings < ActiveRecord::Migration
  def change
    remove_column :recordings, :instrumental
    remove_column :recordings, :release_date
    remove_column :recordings, :audio_file
    remove_column :recordings, :content_type
    remove_column :recordings, :song_id
    remove_column :recordings, :poster
    remove_column :recordings, :crop_params
    remove_column :recordings, :audio_file_tmp
    remove_column :recordings, :album_id
    remove_column :recordings, :extract_id3_tags
    remove_column :recordings, :track_number
    remove_column :recordings, :ogv_video
    remove_column :recordings, :mp4_video
    remove_column :recordings, :webm_video
    remove_column :recordings, :media_type
    remove_column :recordings, :video_width_in_pixels
    remove_column :recordings, :video_height_in_pixels
    remove_column :recordings, :has_title
    remove_column :recordings, :has_lyrics
    remove_column :recordings, :category
    remove_column :recordings, :genre_category
  end
end
