class RemoveCuruptedRecordings < ActiveRecord::Migration
  def change
    
    Recording.all.each do |recording|
      
      unless CommonWork.exists?(recording.common_work_id)
        recording.destroy
      end
    end
  end
end
