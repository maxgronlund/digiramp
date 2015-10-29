class FixPublishingAgreementsOnPersonalPublishers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      personal_publisher = user.personal_publisher
      unless personal_publisher
        publisher = Publisher.create( 
          user_id: user.id,
          personal_publisher: true,
          legal_name: user.get_full_name
        )
        user.update(personal_publisher_id: publisher.id)
        ap '================ personal_publisher created ============================='
        ap personal_publisher
      end
    end
  end
end

#unless publisher = Publisher.find_by( user_id: self.id, id: self.personal_publisher_id)
#   publisher = Publisher.create( 
#     user_id: self.id,
#     personal_publisher: true
#   )
#   self.update(personal_publisher_id: publisher.id)
#   
#end
#publisher