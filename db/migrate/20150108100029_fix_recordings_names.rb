class FixRecordingsNames < ActiveRecord::Migration
  def change

    Recording.find_each do |recording|
      begin
        recording.title = recording.original_file_name if recording.title.to_s == ''
        if recording.title != File.basename(recording.original_file_name, ".*") 
          recording.title = File.basename(recording.original_file_name, ".*")
          recording.save!
        end
      rescue
        count += 1
        recording.title = 'no title'
        recording.save!
      end
    end
  end
end
