class RemoveDeadSubmissions < ActiveRecord::Migration
  def change
    
    MusicSubmission.where(user_id: nil).destroy_all
  end
end
