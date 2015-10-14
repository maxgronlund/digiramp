class CommonWorkIpi < ActiveRecord::Base
  belongs_to :common_work
  belongs_to :ipi
  belongs_to :publishing_agreement
  belongs_to :publisher
  belongs_to :ipi_publisher
  
  validates_presence_of :email, :share
  validates_formatting_of :email, :using => :email
  validates_with CommonWorkIpiValidator
  
  enum status: [ :pending, :accepted, :dismissed, :in_progress ]
  
  after_commit :flush_cache
  
  
  def configure_payment( royalty, price, recording_uuid, common_work_id )
    ap '================================================================'
    ap 'configure_payment'
    ap self
    
    begin
      # send money to the publisher
      royalty_left = self.publishing_agreement.configure_payment( royalty, price, recording_uuid )
      # pay the ip
      self.ipi.configure_payment( royalty_left * share * 0.01 , price, recording_uuid )
    rescue => e
      ErrorNotification.post_object 'CommonWorkIpi#configure_payment', e
    end
   
  end
  
  def publisher_split
    if publishing_agreement
      return publishing_agreement.split
    end
    
  end
  
  def get_full_name
    if ipi = self.ipi
      if user = ipi.user
        return user.full_name if user.full_name != ' '
        return user.user_name
      end
    else
      return  self.full_name
    end
  end
  
  def get_email
    if ipi = self.ipi
      if user = ipi.user
        return user.email
      end
    else
      return  self.email
    end
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  # Attach to the users ip
  def attach_to_ip
    if user = User.get_by_email(self.email)
      self.ipi_id = user.ipi.id
      self.save(validate: false)
      self.attach_to_publishers user
    end
  end
  
  def attach_to_publishers user
    
    #self.publisher_id
    if user.personal_publishing_status == "I have an exclusive publisher" || 
       user.personal_publishing_status == "I own and control my own publishing"
      self.publisher_id  = user.personal_publisher_id
      self.save(validate: false)
      attach_to_publishing_agreement
    else
      ap 'something fancy here'
    end 
  end
  
  def attach_to_publishing_agreement
    
    if ipi_publishers   = publisher.ipi_publishers
      if ipi_publisher  = ipi_publishers.find_by(ipi_id: ipi_id)
        self.update(publishing_agreement_id: ipi_publisher.publishing_agreement_id)
      end
    end
  end

 
  def publishers
    if ipi
      publisher_ids = IpiPublisher.where(ipi_id: self.ipi_id).pluck(:publisher_id)
      Publisher.where(id: publisher_ids)
    end
  end
  
  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
    
    
  
end
