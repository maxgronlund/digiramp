class AddCommonWorkUsersToCommonWorks < ActiveRecord::Migration
  def change
    CommonWork.find_each do |common_work|
      # a user for the manager
      CommonWorkUser.where(
        user_id:          common_work.user_id,
        common_work_id:   common_work.id
      )
      .first_or_create(
        common_work_title:      common_work.title,
        user_id:                common_work.user_id,
        common_work_id:         common_work.id,
        can_manage_common_work:   true
      
      )
      
      
      # a user for each ipi
      common_work.common_work_ipis.where.not(user_id: nil).each do |common_work_ipi|
        if user = common_work_ipi.user
          CommonWorkUser.where(
            user_id:          common_work_ipi.user_id,
            common_work_id:   common_work.id
          )
          .first_or_create(
            common_work_title:        common_work.title,
            user_id:                  common_work_ipi.user_id,
            common_work_id:           common_work.id,
            can_manage_common_work:   false
          
          )
        else
          common_work_ipi.destroy
        end
      end
      
    end
  end
end
