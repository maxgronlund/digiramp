class FixUserPublishers < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      if personal_publisher = user.personal_publisher
        if user_publishers = UserPublisher.where(user_id:  user.id, publisher_id: personal_publisher.id)
          if user_publishers.count > 1
            count = 0
            user_publishers.order(:id).each do |user_publisher|
              unless count == 0
                user_publisher.destroy 
              end
              count += 1
            end
          end
        end
      end
    end
  end
end
