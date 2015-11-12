class FixPublishingAgreementsOnPersonalPublishers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      
      unless user.personal_publisher
        personal_publisher = Publisher.create( 
          user_id:            user.id,
          personal_publisher: true,
          legal_name:         user.get_full_name,
          email:              user.email,
          account_id:         user.account_id
        )
        personal_publisher.confirmed!
        user.personal_publisher_id =  personal_publisher.id
        user.save(validates: false)
        #ap '================ personal_publisher created ============================='
        ap user.personal_publisher
        ap user.personal_publisher_id
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