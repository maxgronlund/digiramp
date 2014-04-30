class AddRecordingIdToImageFiles < ActiveRecord::Migration
  def change
    #add_column :image_files, :recording_id, :integer
    #add_index :image_files, :recording_id
    add_reference :image_files, :recording, index: true
  end
end
