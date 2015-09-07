class Publisher < ActiveRecord::Base
  has_paper_trail
  enum status: [ :pending, :confirmed, :declined ]
  
  
  default_scope -> { order('created_at ASC') }
  #scope :first, -> { order("created_at").first }
  #scope :last, -> { order("created_at DESC").first }
  
  
  validates :legal_name , :email, presence: true
  
  has_many :user_publishers, dependent: :destroy
  has_many :users,   :through => :user_publishers 
  has_many :publishing_agreements
  
  belongs_to :account
  belongs_to :user
  belongs_to :pro_affiliation
  
  has_one :address
  accepts_nested_attributes_for :address
  include AddressMix
  
 
  
  
  validates_with PublisherValidator, fields: [:email] 
  #validates :email, presence: true, uniqueness: true#
  # all users can create publishers
  # sometime they create a user on behalf of someone else
  after_create :create_publisher_user
  after_commit :flush_cache
  
  def check_ownership!

    if self.i_am_my_own_publisher 
      self.confirmed!
    else
      if known_user = User.get_by_email( self.email )
        if self.pending?
          self.transfer_uuid = UUIDTools::UUID.timestamp_create().to_s
          self.save
          #PublisherMailer.delay.request_confirmation_from_existing_user self
          
          
         
        
         
          @message                    = Message.new
          @message.recipient_id       = known_user.id
          @message.sender_id          = user.id
          @message.title              = 'You have been listed as a publisher'
          @message.body               = "Hi #{user.user_name} has listed you as publisher, please click the button for more details" 
          @message.subjectable_id     = self.id
          @message.subjectable_type   = self.class.name
          @message.save!
          @message.send_as_email
          
          
          channel = 'digiramp_radio_' + known_user.email

          Pusher.trigger(channel, 'digiramp_event', {"title" => 'Message received', 
                                                "message" => "#{user.user_name} has listed you as a publisher", 
                                                "time"    => '2000', 
                                                "sticky"  => 'false', 
                                                "image"   => 'notice'
                                                })
          
        
          
          
          
        else
          self.transfer_uuid = nil
          self.save
        end
      else
        self.pending!
        ap 'Notify unknown user, publisher is attached to wrong account untill confirmed'
      end
    end
  end
  
  
  
  
  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def add_user_email!
    if self.i_am_my_own_publisher
      user_email = UserEmail.where(email: self.email, user_id: self.user_id)
                            .first_or_create(email: self.email, user_id: self.user_id)
    end
  end

  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  
  def create_publisher_user
    UserPublisher.where(publisher_id: self.id, user_id: self.user_id)
                 .first_or_create(publisher_id: self.id, user_id: self.user_id)
  end
  
  
  
end
