class RemoveDeadMusicSubmissions < ActiveRecord::Migration
  def change
    
    Recording.find_each do |recording|
      if recording.user.nil?
        recording.destroy
      end
    end
  end
end
