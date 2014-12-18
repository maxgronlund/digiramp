class ConvertRecordingsToZip < ActiveRecord::Migration
  def change
    
    Recording.where(zipp: nil).first(1).each do |recording|
      puts '---------'
      puts recording.title
      puts '---------'
      recording.zip
      ap recording
    end
  end
end
