class AttachRecordingsToCommonWorks < ActiveRecord::Migration
  def change
    Recording.find_each do |recording|      
      recording.attach_to_common_work
    end
  end
end
