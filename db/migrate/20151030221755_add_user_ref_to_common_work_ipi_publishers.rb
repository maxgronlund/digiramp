class AddUserRefToCommonWorkIpiPublishers < ActiveRecord::Migration
  def change
    add_reference :common_work_ipi_publishers, :user, index: true
    
    CommonWorkIpiPublisher.find_each do |common_work_ipi_publisher|
      user = common_work_ipi_publisher.common_work_ipi.user
      common_work_ipi_publisher.update(user_id: user.id)
    end
    
  end
end
