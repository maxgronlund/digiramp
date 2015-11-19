class SetCommonWorkUserOnAllRecordings < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      user.recordings.each do |recording|
        if common_work = recording.common_work
          if common_work_user = CommonWorkUser.find_by(user_id: user.id, common_work_id: common_work.id)
            
          else
            ap '------------------------------'
            ap common_work.title
            ap common_work.common_work_users
            CommonWorkUser.create(
              user_id: user.id, 
              common_work_id: common_work.id,
              common_work_title: common_work.title,
              can_manage_common_work: true
            )
          end
        else
          ap " common_work is missing for recording: #{recording.id}"
        end
        
      end
      
    end
  end
end
