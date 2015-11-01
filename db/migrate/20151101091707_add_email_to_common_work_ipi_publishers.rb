class AddEmailToCommonWorkIpiPublishers < ActiveRecord::Migration
  def change
    add_column :common_work_ipi_publishers, :email, :string
    
    CommonWorkIpiPublisher.find_each do |common_work_ipi_publisher|
      if publisher = common_work_ipi_publisher.publisher
        common_work_ipi_publisher.update(email: publisher.email)
      end
      
    end
  end
end
