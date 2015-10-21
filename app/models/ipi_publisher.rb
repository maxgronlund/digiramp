# This class joyn a publisher with an Ipi
# All users can own one or many publishing companies
# From a publishing company the owner can invite creators to be published
 


class IpiPublisher < ActiveRecord::Base
  belongs_to :ipi
  belongs_to :user
  belongs_to :publisher
  belongs_to :publishing_agreement
  
  validates :email, presence: true
  validates_formatting_of :email, :using => :email
  enum status: [ :pending, :confirmed ]
  
  after_commit :flush_cache
  
  before_destroy :reset_common_work_ipis
  
  
  def reset_common_work_ipis
    CommonWorkIpi.where(
      email: self.email, 
      ipi_publisher_id: self.id
    )
    .update_all(
      email: self.email, 
      ipi_publisher_id: nil
    )
    
  end


  
  def attach_to_user current_user
    user = User.find_or_create_from_email(self.email)
      self.update(
        ipi_id:  user.ipi.id,
        user_id: user.id,
        email:   user.email
      )
      self.confirmed! if current_user == user
   if user.account_activated
     send_notification unless self.user == current_user
   else
     user.add_token 
     send_invitation user
   end
  end
  
  
  
  


  # notify the user about creation / update by email
  def send_notification
    PublisherMailer.delay.send_notification self.id
  end
  
  # invite a user to digiramp
  def send_invitation user
    PublisherMailer.delay.send_invitation self.id
  end
  
  def update_validation
    
  end
  
  
  
  
  
  # When a user sets his own publishing
  def attach_to_common_work_ipis
    
    CommonWorkIpi.where(
      email: self.email, 
      ipi_publisher_id: nil
    )
    .update_all(
      email: self.email, 
      ipi_publisher_id: self.id
    )
  end
  
  # get the publishers legal name
  def title
    return publisher.legal_name if publisher
    'na'  
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      update_validation unless self.destroyed?
      Rails.cache.delete([self.class.name, id])
    end
  
end
