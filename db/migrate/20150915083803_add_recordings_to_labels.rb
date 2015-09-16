class AddRecordingsToLabels < ActiveRecord::Migration
  def change
    
    Label.find_each do |label|
      user = label.user
      
      user.recordings.each do |recording|
        LabelRecording.create(recording_id: recording.id, label_id: label.id)
      end
    end
  end
end
