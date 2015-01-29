class FixMusicSubmisions < ActiveRecord::Migration
  def change
    MusicSubmission.find_each do |music_submission|
      ap '---------- music_submission.user_id -----------'
      ap music_submission.user_id
      if music_request = music_submission.music_request
        ap 'music_request.id:'
        ap music_request.id
        if opportunity = music_request.opportunity
          ap 'opportunity.id:'
          ap opportunity.id
          
          
          if opportunity_user = OpportunityUser.where(user_id: music_submission.user_id, opportunity_id: opportunity.id).first

            ap 'opportunity_user.id:'
            ap opportunity_user.id
            
            if music_submission.opportunity_user_id != opportunity_user.id
              '============= BAM ================'
            else
              '√ ok'
            end
          else
            puts '--- error ---'
            puts 'no music opportunity_user'
            music_submission.opportunity_user_id = nil
            music_submission.save!
          end
          
        else
          puts '--- error ---'
          puts 'no music opportunity'
        end
        
      else
        puts '--- error ---'
        puts 'no music request'
      end
      
    end
  end
end
