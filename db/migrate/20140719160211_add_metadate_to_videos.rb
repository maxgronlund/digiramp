class AddMetadateToVideos < ActiveRecord::Migration
  def change
    
    #remove_column :videos, :uploads,     :text
    remove_column :videos, :mp4_video,   :text
    remove_column :videos, :webm_video,  :text
    
    
    add_column :videos, :duration,          :string,                default: ''
    add_column :videos, :width,             :integer,               default: 0
    add_column :videos, :height,            :integer,               default: 0
    add_column :videos, :framerate,         :integer,               default: 0
    add_column :videos, :video_bitrate,     :integer,               default: 0
    add_column :videos, :overall_bitrate,   :integer,               default: 0
    add_column :videos, :video_codec,       :string, default: ''
    add_column :videos, :audio_bitrate,     :integer,               default: 0
    add_column :videos, :audio_samplerate,  :integer,               default: 0
    add_column :videos, :audio_channels,    :integer,               default: 0
    add_column :videos, :audio_codec,       :string, default: ''
    add_column :videos, :seekable,          :string, default: ''
    add_column :videos, :date_recorded,     :string, default: ''
    add_column :videos, :date_file_created, :string, default: ''
    add_column :videos, :date_file_modified, :string, default: ''
    add_column :videos, :device_vendor, :string, default: ''
    add_column :videos, :device_name, :string, default: ''
    add_column :videos, :device_software, :string, default: ''
    add_column :videos, :latitude, :string, default: ''
    add_column :videos, :longitude, :string, default: ''
    add_column :videos, :rotation,           :integer,               default: 0
    add_column :videos, :album, :string, default: ''
    add_column :videos, :comment, :string, default: ''
    add_column :videos, :year, :string, default: ''
    

    
    add_column :videos, :uploads,     :text
    add_column :videos, :mp4_video,   :text
    add_column :videos, :webm_video,  :text
    
    add_column :videos, :mp4_video_url,  :string, default: ''
    add_column :videos, :webm_video_url, :string, default: ''
    
    add_column :videos, :name,              :string,          default: ''
    add_column :videos, :basename,          :string,          default: ''
    add_column :videos, :ext,               :string,          default: ''
    add_column :videos, :size,              :integer,         default: 0
    add_column :videos, :mime,              :string,          default: ''
    add_column :videos, :video_type,        :string,          default: ''
    add_column :videos, :md5hash,           :string,          default: ''
    add_column :videos, :original_id,       :string,          default: ''
    add_column :videos, :original_basename, :string,          default: ''
    add_column :videos, :original_md5hash,  :string,          default: ''
                   
  end
end

