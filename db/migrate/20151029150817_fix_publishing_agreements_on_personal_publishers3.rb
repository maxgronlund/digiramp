class FixPublishingAgreementsOnPersonalPublishers3 < ActiveRecord::Migration
  def change
    
    Publisher.find_each do |publisher|
      publisher.update(account_id: publisher.user.account_id)
    end
      
    PublishingAgreement.find_each do |publishing_agreement|
      publishing_agreement.update(account_id: publishing_agreement.publisher.account_id)
    end
      
    User.find_each do |user|
      personal_publisher =  user.personal_publisher
      
      unless publishing_agreement = PublishingAgreement.find_by(personal_agreement: true, publisher_id: personal_publisher.id)
        publishing_agreement = PublishingAgreement.create(
          publisher_id:       personal_publisher.id,
          title:              "Personal publishing agreement for #{user.get_full_name}",
          split:              0.0,
          personal_agreement: true,
          expires:            false,
          user_id:            user.id,
          uuid:               UUIDTools::UUID.timestamp_create().to_s,
          ok:                 false,
          account_id:         user.account_id
        
        )
      end
      
    end
       
  end
end


