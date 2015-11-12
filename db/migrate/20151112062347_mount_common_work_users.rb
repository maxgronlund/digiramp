class MountCommonWorkUsers < ActiveRecord::Migration
  def change
    CommonWork.find_each do |common_work|
      if common_work.common_work_users.empty?
        CommonWorkUser.create(
          common_work_id: common_work.id,
          common_work_title: common_work.title,
          user_id: common_work.user_id,
          can_manage_common_work: true
        )
      end
    end
  end
end
