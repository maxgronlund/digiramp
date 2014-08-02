class FixOldMusicSubmissions < ActiveRecord::Migration
  def change
    
    MusicSubmission.all.each do |music_submission|
      if music_submission.opportunity_user_id.nil?
        music_submission.destroy! 
      else
        music_submission.account_id = music_submission.recording.account_id
        music_submission.save!
      end
    end
  end
end
