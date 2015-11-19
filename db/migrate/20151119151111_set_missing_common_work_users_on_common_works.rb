class SetMissingCommonWorkUsersOnCommonWorks < ActiveRecord::Migration
  def change
    CommonWork.find_each do |common_work|
      common_work.ipis.each do |ipi|
        if user = ipi.user
          unless common_work_user = CommonWorkUser.find_by( user_id: user.id, common_work_id: common_work.id)
            ap "common_work_user not found for #{common_work.title}: #{user.user_name}"
            CommonWorkUser.create( 
              user_id: user.id, 
              common_work_id: common_work.id,
              can_manage_common_work: user.id == common_work.user_id
            )
          end
        end
      end
    end
    
  end
end
