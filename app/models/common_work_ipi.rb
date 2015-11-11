# This class connect an Ipi with a CommenWork. 
# It also links to all entity of interest
# * common work
# * user
# * publishing_agreement
# * publisher

class CommonWorkIpi < ActiveRecord::Base
  include NotificationModule
  belongs_to :common_work
  belongs_to :ipi
  belongs_to :user
  belongs_to :publishing_agreement
  #belongs_to :publisher
  #belongs_to :ipi_publisher
  has_many :common_work_ipi_publishers, dependent: :destroy
  has_many :publishers, through: :common_work_ipi_publishers
  
  validates_presence_of :email, :share
  validates_formatting_of :email, :using => :email
  validates_with CommonWorkIpiValidator
  
  enum status: [ :pending, :accepted, :confirmed, :dismissed, :in_progress ]
  
  after_commit :flush_cache
  
  has_many :notification_messages, as: :asset, dependent: :destroy
  
  before_destroy :sanitize_relations
  
  
  def sanitize_relations
    common_work_user.destroy if common_work_user
  end
  

  

  # Configure the payment 
  def configure_payment( royalty, price, recording_uuid, common_work_id )

    begin
      # send money to the publisher
      royalty_left = self.publishing_agreement.configure_payment( royalty, price, recording_uuid )
      # pay the ip
      self.ipi.configure_payment( royalty_left * share * 0.01 , price, recording_uuid )
    rescue => e
      ErrorNotification.post_object 'CommonWorkIpi#configure_payment', e
    end
   
  end
  
  # Get the publisher split based on the publishing agreement
  def publisher_split
    if publishing_agreement
      return publishing_agreement.split
    end
  end
  
  # Get full name
  # If a user is connected the users full name is returned
  def get_full_name
    if self.user 
      return user.get_full_name
    else
      return  self.full_name
    end
  end
  
  def get_publishers
    
  end
  
  # Get the email from the IP
  #
  # if no IP is attached return the email the common_work_ipi was created with
  def get_email
    if ipi = self.ipi
      if user = ipi.user
        return user.email
      end
    else
      return  self.email
    end
  end
  
  

  

  # Find attach the user based on the email
  # If user is equal to current user the status is set to confirmed
  # If no user is found <<tt>send_notification</tt> is called
  # Else <<tt>send_notification</tt> called
  def attach_to_user current_user
    #ap 'CommonWorkIpi#attach_to_user'
    begin
      user = User.find_or_create_from_email(self.email)

      self.update(
        user_id:      user.id,
        email:        user.email,
        #publisher_id: user.get_publisher_id,
        ipi_id:       user.ipi.id,
        status:       user == current_user ? 2 : 0
      )
 
      if user.account_activated
        send_notification(current_user.id) unless self.confirmed?
      else
        user.add_token 
        send_invitation( user, current_user.id)
      end
    rescue
      ErrorNotification.post "CommonWorkIpi#attach_to_user : #{self.id}"
    end
  end

  # notify the user about creation / update by email
  def send_notification current_user_id
    #ap "send_notification"
    CommonWorkIpiMailer.delay.send_notification( self.id, current_user_id )
  end
  
  # invite a user to digiramp
  def send_invitation( user, current_user_id )
    #ap "send_invitation"
    CommonWorkIpiMailer.delay.send_invitation( self.id, current_user_id )
  end

 
  # Get the user if the user dont exists try the ip's user
  def get_user
    return self.user if self.user
    if ipi = self.ipi
      return ipi.user
    end
  end
  
  # Check if the 
  def belongs_to_current_user? current_user
    get_user && (get_user == current_user )
  end
  
  # get the users publishers
  def publishers
    if ipi
      publisher_ids = IpiPublisher.where(ipi_id: self.ipi_id).pluck(:publisher_id)
      Publisher.where(id: publisher_ids)
    end
  end
  
  

  def can_manage_common_work()        
    common_work_user ? common_work_user.can_manage_common_work : false
  end
  
  def can_manage_common_work=( b )
    if common_work_user
      b = true if( common_work_user.user_id == common_work.user_id )
      common_work_user.update(can_manage_common_work: b) 
    end
  end

  def common_work_user
    CommonWorkUser.find_by(user_id: self.user_id, common_work_id: self.common_work_id)
  end
  
  # validate or build an error message 
  def error_message
    em = {}
    unless self.email
      em[:email] = message_hash(self, 'Email missing')
    end
    
    if _ipi = self.ipi
      _error_message = _ipi.error_message
      em[:ipi] = _error_message unless _error_message.empty?
    else
      em[:ipi] = message_hash( self, 'Creator not signed up')
    end
    
    if self.pending?
      em[:status] = message_hash( self, 'Confirmation is pending')
    end
    
    if self.user
      if user.has_to_set_publishing?
        em[:publishing] = message_hash(self, "#{user.get_full_name} publishing status not set")
      else
        self.common_work_ipi_publishers(true).each do |common_work_ipi_publisher|
          common_work_ipi_publisher.update_validation
        end
      end
    else
      em[:user] = message_hash( self, 'User is missing')
    end
    
    em
  end
  
  # set the error flag and let the validation check buble up the stack
  def update_validation
    #ap 'CommonWorkIpi#update_validation'
    set_ok
    self.common_work.update_validation if self.common_work
  end
  
  # check if the common_work_ipi is ok
  def do_validation
    #ap 'CommonWorkIpi#do_validation'
    #ap "id: #{self.id}"
    #ap "ok: #{self.ok}"
    return true if self.ok
    set_ok
    self.ok
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  private 
  
    # set the ok flag
    def set_ok
     # ap 'CommonWorkIpi#set_ok'
      em = error_message
      
      if self.user
        self.update( ok: em.empty? ) 
        #ap '-----------------------------------------------'
        #ap "id: #{self.id}"
        #ap "ok: #{self.ok}"
        #ap em
        #ap '-----------------------------------------------'
        self.ok ? 
          remove_notification_message(self, self.user_id) : 
          update_notification_message(self, self.user_id).update(error_message: em )
      end
    end


    def flush_cache
      #ap 'CommonWorkIpi#flush_cache'
      #update_validation unless self.destroyed?
      Rails.cache.delete([self.class.name, id])
    end
    
    
  
end
