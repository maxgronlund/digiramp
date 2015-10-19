# This class connect an Ipi with a CommenWork. 
# It also links to all entity of interest
# * common work
# * user
# * publishing_agreement
# * publisher
# * ipi_publisher
class CommonWorkIpi < ActiveRecord::Base
  include NotificationModule
  belongs_to :common_work
  belongs_to :ipi
  belongs_to :user
  belongs_to :publishing_agreement
  belongs_to :publisher
  belongs_to :ipi_publisher
  
  validates_presence_of :email, :share
  validates_formatting_of :email, :using => :email
  validates_with CommonWorkIpiValidator
  
  enum status: [ :pending, :accepted, :confirmed, :dismissed, :in_progress ]
  
  after_commit :flush_cache
  
  has_many :notification_messages, as: :assetable, dependent: :destroy
  

  

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
  #
  # If no user is found <<tt>send_notification</tt> is called
  # Else <<tt>send_notification</tt> called
  def attach_to_user current_user
    self.pending!
    if belongs_to_current_user?( current_user )
      
      self.update_columns(
        user_id:    current_user.id,
        email:      current_user.email,
        full_name:  current_user.get_full_name
      )
    else
      self.user ? send_notification : check_for_member
    end
    ap self
  end
  
  # notify the user about creation / update by email
  def send_notification
    self.pending!
    CommonWorkIpiMailer.delay.send_notification self.id
    update_validation
  end
  
  # check if the is a member with the email
  def check_for_member
    if user = User.get_by_email(self.email)
      self.update_columns(
        user_id:   user.id,
        email:     user.email,
        full_name: user.get_full_name
      )
      send_notification
    else
      invite_user
    end
  end
  
  # Invite a new user to digiramp and send a notification
  def invite_user
    if self.email
      destroy_email_missing_notification
    else
      create_email_missing_notification
    end
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
  
  # set the error flag and let the validation check buble up the stack
  def update_validation
    set_ok
    ap self
    self.common_work.update_validation
  end
  
  # check if the common_work_ipi is ok
  def do_validation
    return true if self.ok
    set_ok
    self.ok
  end
  
  # build a message has for the error message
  def message_hash msg
    {
      message:      msg,
      type: self.class.name,
      id:   self.id
    }
  end
  
  # build an error message 
  def error_message
    em = {}
    unless self.email
      em[:email] = message_hash('Email missing')
    end
    
    if _ipi = self.ipi
      _error_message = _ipi.error_message
      em[:ipi] = _error_message unless _error_message.empty?
    else
      em[:ipi] = message_hash('Creator not signed up')
    end
    
    if self.pending?
      em[:status] = message_hash('Creator confirmation is pending')
    end
    em
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  private 
  
   # set the ok flag
    def set_ok
      em = error_message

      if self.user
        update_columns( ok: em.empty? ) 
        self.ok ? remove_notification_message(self.user_id) : 
          update_notification_message(self.user_id).update_columns(
            error_message: em
          )
      end
    end


    def flush_cache
      update_validation
      Rails.cache.delete([self.class.name, id])
    end
    
    
  
end
