class SecureUserPublishers < ActiveRecord::Migration
  def change
    Publisher.find_each do |publisher|
      UserPublisher.where(
        user_id:           publisher.user_id,
        publisher_id:      publisher.id
      
      )
      .first_or_create(
        user_id:           publisher.user_id,
        publisher_id:      publisher.id,
        email:             publisher.email
      )
      
    end
  end
end
