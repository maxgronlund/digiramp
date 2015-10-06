class ReconectDefaultPublishersToUsers < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      begin
        user.update(personal_publisher_id: user.publishers.first.id)
        ap user.personal_publisher_id
      rescue
        create_publisher user
      end
    end
  end
  
  def create_publisher user
    publisher = Publisher.create(
      user_id: user.id,
      account_id: user.account_id,
      legal_name: "#{user.user_name} Publishing",
      email:      user.email,
      personal_publisher: true,
      show_on_public_page: false 
    )
    user.update(personal_publisher_id: publisher.id)
    publisher.confirmed!
    
    
    publishing_agreement = PublishingAgreement.create(
      publisher_id:       publisher.id,
      split:              50.0,
      title:              "Publishing agreement for #{user.user_name}",
      personal_agreement: true,
      user_id:            user.id,
      account_id:         user.account_id, 
      uuid: UUIDTools::UUID.timestamp_create().to_s
    )

  end
  
  
end
