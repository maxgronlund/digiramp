class AddAudioUploadToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :audio_upload, :text
  end
end
