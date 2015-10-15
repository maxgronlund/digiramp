# This class connect an Ipi with a CommenWork. 
# It also links to all entity of interest
# * common work
# * user
# * publishing_agreement
# * publisher
# * ipi_publisher
class CommonWorkIpi < ActiveRecord::Base
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
  
  before_destroy :sanitize_relations
  
  # Remove user_notifications
  def sanitize_relations
    if user_notifications = UserNotification.where(asset_id: self.id, asset_type: self.class.name)
      user_notifications.destroy_all
    end
  end
  
  # Configure the payment 
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
    ap 'attach_to_user'
    if belongs_to_current_user?( current_user )
      ap 'belongs to current_user'
      self.update_columns(
        user_id:    current_user.id,
        email:      current_user.email,
        full_name:  current_user.get_full_name
      )
    else
      self.user ? send_notification : check_for_member
    end
  end
  
  # notify the user about creation / update
  def send_notification
    
    creat_confirm_common_work_ipi_notification
    CommonWorkIpiMailer.delay.send_notification self.id
    destroy_email_missing_notification
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
    ap '-- invite_user --'
    if self.email
      User.send_invitation( 
        email:   self.email,
        type:    self.class.name,
        id:      self.id
      )
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
  
  # Remove user_notification when a problem is solved
  def destroy_email_missing_notification
    begin
      if user_notification = UserNotification.find_by( 
          user_id:    self.common_work.account.user_id,
          asset_type: self.class.name,
          asset_id:   self.id,
          status: 'error', 
          message: 'Email missing'
        )
        user_notification.destroy
      end
    rescue
      ap 'account is missing'
      ap common_work.title
    end
  end
  
  # Create a notification for the owner of the common work about an email for a common_work_ip is missing
  def create_email_missing_notification
    UserNotification.where( 
        user_id:    self.common_work.account.user_id,
        asset_type: self.class.name,
        asset_id:   self.id,
        status: 'error',
        message: 'Email missing'
      ).first_or_create( 
        user_id:    self.common_work.account.user_id,
        asset_type: self.class.name,
        asset_id:   self.id,
        status: 'error',
        message: 'Email missing'
      )
  end
  
  # Create a notification for a user that he has to confirm his role on a common_work as a creator
  def creat_confirm_common_work_ipi_notification
    
    UserNotification.where( 
        user_id:    self.user_id,
        asset_type: self.class.name,
        asset_id:   self.id,
        status:     'notice',
        message:    'Confirm role'
      ).first_or_create( 
        user_id:    self.user_id,
        asset_type: self.class.name,
        asset_id:   self.id,
        status:     'notice',
        message:    'Confirm role'
      )
  end
  
  
  

  
  
  #def invite_new_publisher
  #  
  #end
  #
  #def attach_to_publishing_agreement
  #  
  #  if ipi_publishers   = publisher.ipi_publishers
  #    if ipi_publisher  = ipi_publishers.find_by(ipi_id: ipi_id)
  #      self.update(publishing_agreement_id: ipi_publisher.publishing_agreement_id)
  #    end
  #  end
  #end

 
  def publishers
    #if self.user
    #  user.common_work_publishers(self.id)
    #end
    if ipi
      publisher_ids = IpiPublisher.where(ipi_id: self.ipi_id).pluck(:publisher_id)
      Publisher.where(id: publisher_ids)
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
    
    
  
end
