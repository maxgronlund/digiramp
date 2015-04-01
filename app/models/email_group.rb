class EmailGroup < ActiveRecord::Base
  
  has_many :digiramp_emails, dependent: :destroy
  has_many :mail_list_subscribers, dependent: :destroy
  has_many :users, through: :mail_list_subscribers
  
  before_create :set_uuid
  
  def recipients=(recipients)


    recipients.split(',').each do |recipient|
      
      if email = EmailSanitizer.saintize( recipient )
        if user = User.where(email: email).first
          mail_list_subscriber = MailListSubscriber.where(user_id: user.id, email_group_id: self.id)
                                                    .first_or_create(user_id: user.id, email_group_id: self.id)

        end
      end
    end
   
  end
  
  def recipients
    
  end
  
  def set_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
end
