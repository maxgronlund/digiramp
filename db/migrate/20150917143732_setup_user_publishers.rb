class SetupUserPublishers < ActiveRecord::Migration
  def up
    
    add_reference :documents, :belongs_to, polymorphic: true, index: true
    add_reference :publishing_agreements, :account, index: true, foreign_key: false
    add_reference :document_users, :digital_signature, index: true
    add_reference :publishing_agreements, :user, index: true, foreign_key: false
    
    Publisher.destroy_all
    PublishingAgreement.destroy_all
    
    User.find_each do |user|
      user.setup_personal_publishing
    end

  end
  
  def down
    remove_reference :documents, :belongs_to, polymorphic: true, index: true
    remove_reference :publishing_agreements, :account, index: true, foreign_key: false
    remove_reference :document_users, :digital_signature, index: true
  end
  

end
