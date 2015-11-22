################################# 
# a user can be created by someone else than the user
# E:G: an other user can add the user as a client to his account.
# In that case there is send no notification to the user
# and the user is marked as not signed up
# account users with the role 'Client' can not se the accounts where they are clients


class User < ActiveRecord::Base
  

  
  extend FriendlyId
  friendly_id :user_name, :use => :history
  #friendly_id :user_name, use: :slugged
  
  scope :public_profiles,   ->  { where( private_profile: false)  }
  scope :supers,            ->  { where( role: 'Super' ).order("email asc")  }
  scope :administrators,    ->  { where( administrator: true ).order("email asc")  }
  scope :customers,         ->  { where( role: 'Customer' ).order("email asc")  }
  scope :with_a_collection, ->  { where( has_a_collection: true)}
  
  has_paper_trail 
  has_secure_password
  include PublicActivity::Common
  
  
  include PgSearch
  #pg_search_scope :search_user, against: [:search_field], :using => [:tsearch]
  pg_search_scope :search_user,  against: [ :search_field
                                    ], 
                                using: {  
                                          tsearch: { prefix: true, 
                                                     any_word: true, 
                                                     dictionary: "english"
                                                    },
                                          dmetaphone: {:any_word => true, :sort_only => true}
                                        }
                                        #,
                                #ignoring: :accents
                                    
                                    
  ROLES           = ["Super", "Customer", "Backend Editor"]
  SECRET_NAME     = "RGeiHK8yUB6a"
  PUBLISHING_TYPE = ['Publishing is not configured','I own and control my own publishing', 'I have an exclusive publisher', 'I have many publishers' ]
  enum status: [ :has_to_set_publishing, :is_self_published, :has_an_exclusive_publisher, :have_many_publishers ]
  validates :email, presence: true, uniqueness: true
  validates_formatting_of :email
  validates_with UserValidator
  validates_presence_of :user_name
  validates_presence_of :password, :on => :create
  validates_formatting_of :link_to_facebook        , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_twitter         , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_linkedin        , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_google_plus     , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_tumblr          , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_instagram       , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_youtube         , :using => :url, :allow_blank => true      # URLs
  validates_formatting_of :link_to_homepage        , :using => :url, :allow_blank => true      # URLs


  has_one :ipi, dependent: :destroy
  has_one :address
  #has_one :publisher
  accepts_nested_attributes_for :address
  #accepts_nested_attributes_for :publisher
  include AddressMix
  
  has_one  :account
  has_one  :user_configuration
  has_many :account_users
  has_many :accounts,         :through => :account_users  
  has_many :labels
  has_many :common_works
  has_many :common_work_users
  
  # A user can have many publishers that he uses for publishing other persons
  #has_many :user_publishers
  #has_many :publishers,       :through => :user_publishers 
  #has_many :publishers
  has_many :distribution_agreements
  
  has_many :comments,        as: :commentable,          dependent: :destroy
  has_many :digital_signatures 
  has_many :recording_downloads, dependent: :destroy
  has_many :selected_opportunities
  has_many :client_invitations
  has_many :subscriptions
  has_many :recording_ipis
  has_many :client_invitation
  
  has_many :common_work_ipis
  has_many :common_work_ipi_publishers
 
  

  serialize :crop_params, Hash
  serialize :seller_info,  JSON
  mount_uploader :image, AvatarUploader
  #include ImageCrop

  belongs_to :page_style
  has_many :recordings
  has_many :client_imports
  
  # used to display the users recordings
  has_many :widgets, dependent: :destroy
  
  # omniauth
  has_many :authorization_providers,    dependent: :destroy
  has_many :catalog_users,              dependent: :destroy
  has_many :catalogs, through: :catalog_users
  has_many :opportunity_users,          dependent: :destroy
  has_many :opportunities, through: :opportunity_users
  has_many :music_submission_selections
  

  has_one :dashboard
  #has_many :work_users,               dependent: :destroy
  #has_many :works,                    through: :work_users
  has_many :invites
  
  # account_catalog a user administrates
  has_many :administrations
  has_many :account_catalogs, through: :administrations

  # for the crm
  has_many :project_tasks
  has_many :projects
  
  #has_many :ipis
  has_many :user_credits, dependent: :destroy
  has_many :issues,       dependent: :destroy
  has_many :user_notifications
  has_many :notification_messages
  

  # Activities
  has_many :activity_events, as: :activity_eventable

  has_many :share_on_facebooks, dependent: :destroy
  has_many :share_on_twitters,  dependent: :destroy
  

  after_commit    :set_propperties

  before_create   :setup_basics
  after_create    :set_default_relations
  before_destroy  :sanitize_relations
  
  
  #has_many :emails, dependent: :destroy
  
  # statistic on playbacks
  has_many :playbacks
  has_many :recording_views
  
  # statistic on likes
  has_many :likes
  
  # stuff a user like used for users
  has_many :item_likes
  
  has_many :playlists
  
  # -----------------------------------------------------------------
  # followers
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :relationships, foreign_key: "follower_id"
  
  has_many :reverse_relationships, foreign_key: "followed_id",
                                     class_name:  "Relationship",
                                     dependent:   :destroy
  
  has_many :followers, through: :reverse_relationships, source: :follower
  
  #------------------------------------------------------------------
  # the creator of the event
  has_many :follower_events, dependent: :destroy
  #------------------------------------------------------------------
  # messages
  has_many :received_massages,  class_name: "Message", foreign_key: "recipient_id"
  has_many :send_massages,      class_name: "Message", foreign_key: "sender_id"
  #------------------------------------------------------------------
  # connections
  has_many :connections
  has_many :connected, :through => :connections

  # posts on the wall
  has_many :wall_posts, :through => :follower_event_users, :source => :follower_event
  has_many :follower_event_users
  
  has_many :mail_list_subscribers, dependent: :destroy
  has_many :email_groups, through: :mail_list_subscribers
  
  has_many :music_submission, dependent: :destroy
  
  has_many :opportunitiy_views
  
  has_many :clients
  has_many :client_groups
  
  has_many :forums, dependent: :destroy
  has_many :campaigns
  has_many :cms_pages
  has_many :contracts
  has_many :user_emails, dependent: :destroy
  
  has_many :creative_projects, dependent: :destroy
  has_many :payment_sources, dependent: :destroy
  has_many :playlist_emails, dependent: :destroy
  
  #has_one :default_cms_page
  
  has_many :orders, class_name:           'Shop::Order'
  has_many :products, class_name:         'Shop::Product'
  has_many :stripe_transfers, class_name: 'Shop::StripeTransfer'
  #has_many :entries, through: :entries_media, class_name: 'Cms::ContentEntry', source: :entry
  
  has_many :document_users
  has_many :documents, through: :document_users
  has_many :distribution_agreements
  has_many :publishing_agreements
  has_many :user_publishers, dependent: :destroy
  has_many :publishers, through: :user_publishers
  
  
  #def account_id() @account_id ||= self.account.id end
  def account_id() self.account.id end
  
  def digital_signature
    return nil if self.digital_signature_uuid.nil?
    signature = DigitalSignature.find_by(uuid: self.digital_signature_uuid)
    return nil if signature.hidden
    signature
  end
  
  def emails
    mails = self.user_emails.map { |mail| mail.email  }
    mails << self.email
  end
  
  
  
  def next_up?
    self.user_configuration.next_up?
  end
  
  def administrated_by user
    
  end

  def personal_publishing_status
    case self.status 
    when "has_to_set_publishing"
      return "Publishing is not configured"
    when "is_self_published"
      return "I own and control my own publishing"
    when "has_an_exclusive_publisher"
      return "I have an exclusive publisher"
    when "have_many_publishers"
      return "I have many publishers"
    end
  end
  
  def publishing
    case self.status 
    when "has_to_set_publishing"
      return "Not configured"
    when "is_self_published"
      return "Self published"
    when "has_an_exclusive_publisher"
      return "Exclusive published"
    when "have_many_publishers"
      return "Has many publishers"
    end
  end

  def personal_publishing_status=(status)
    case status 
    when "I own and control my own publishing"
      self.is_self_published!
    when "I have an exclusive publisher"
      self.has_an_exclusive_publisher!
    when "I have many publishers"
      self.have_many_publishers! 
    else
      self.has_to_set_publishing!
    end
  end
  
  # user by?
  def permits? current_user
    # users can access their own profile
    return false if current_user.nil?
    return true if current_user.id == self.id
    return true if self.account.administrator_id == current_user.id
    # super user can access all profiles 
    return true if current_user.role == 'Super'
    # no access
    false
  end
  
  
  def has_no_recordings_on_playlist?
    self.playlists.each do |playlist|
      return false if playlist.recordings.count > 0
    end
  end
  
  def has_no_cleared_recording?
    self.recordings.each do |recording|
      return false if recording.is_cleared?
    end
    return true
  end
  
  def first_uncleared_recording
    self.recordings.each do |recording|
      return recording unless recording.is_cleared?
    end
    nil
  end
  
  def get_documents
    self.documents
    #documents.publishing_agreements.where(status: [0, 1, 2])
    #  [ :draft, :execution_copy, :executed, :deleted ]
  end
  
  def liked_users
    user_ids = self.item_likes.where(like_type: 'User').pluck(:id)
    User.order(:id).where(id: user_ids).public_profiles
  end

  
  def liked_by user_id
    ItemLike.find_by(user_id: user_id, like_id: self.id, like_type: self.class.name)
  end
  
  def update_user_likes
    # how many has liked this user
     # how many has this user liked
    self.update(
      user_likes: ItemLike.where(like_id: self.id, like_type: self.class.name).count
    )
  end
  
  def update_liked_users_count
    # how many has liked this user
     # how many has this user liked
    self.update(
      liked_users_count: liked_users.count,
      has_liked_a_user:  liked_users.count > 0
    )
    
    ap self.has_liked_a_user

  end
  
  #def user_likes 
  #  ItemLike.where(like_id: self.id, like_type: self.class.name).count
  #end
  
  def update_shop
    conneted_to_stripe    = !authorization_providers.where(provider: 'stripe_connect').empty?
    self.update(has_enabled_shop: conneted_to_stripe)
    self.products.update_all(connected_to_stripe: conneted_to_stripe)
  end
  
  

  def self.say_hello
    #TestMailer.delay.send_message() 
    #if Rails.env == 'development'
    #  TestMailer.delay.send_message() 
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'========================================= say hello ========================================='
    #  #'...'
    #  #'...'
    #end
  end
  def get_order
    
    # lock if there is a order in the process of being paid

    
    @shop_order  = Shop::Order.where( state: 'pending', 
                                      user_id: self.id,
                                      email: self.email )
                              .first_or_create!( user_id: self.id, 
                                                 email: self.email,
                                                 invoice_nr: Admin.get_invoice_nr
                                                )
    @shop_order.errors.clear
    @shop_order
  end
  
  def is_stripe_connected
    return true if self.authorization_providers.find_by(provider: 'stripe_connect')
    false
  end
  
  def seller_info

    if is_stripe_connected
      StripeAccount.info(self)
    else
      message = "User#seller_info: #{self.email} not connected to stripe"
      
      Opbeat.capture_message( message )
      {
                            :id => "error",
                         :email => "peter@digiramp.com",
          :statement_descriptor => "DIGIRAMP.COM",
                  :display_name => "DigiRAMP",
                      :timezone => "America/Los_Angeles",
                       :country => "DK",
                 :business_name => "DigiRAMP",
                  :business_url => "digiramp.com",
                 :support_phone => "+13236540591",
               :payment_gateway => "stripe",
                       :user_id => 1
      }
    end
  end
  
  def remove_stripe_credentials
    
    self.stripe_id              = nil
    self.stripe_access_key      = nil
    self.stripe_publishable_key = nil
    self.stripe_refresh_token   = nil
    self.stripe_customer_id     = nil
    self.save
    
  end
  
  def merge_order order_id
    begin
      if old_shop_order = Shop::Order.cached_find( order_id )
        get_order.merge_with_and_delete old_shop_order
      end
    rescue
    end
  end
  
  # test if a user has an email
  def has_email test_this_email
    test_this_email.downcase!
    return true if test_this_email == self.email
    return true if self.user_emails.where(email: test_this_email).first
    false
  end
  
  def self.get_by_email get_by_email
    return nil unless get_by_email
    get_by_email.downcase!
    if user =  User.find_by(email: get_by_email)
      return user
    elsif user_email = UserEmail.where(email: get_by_email).first
      return user_email.user if user_email.user
    end 
    nil
  end

  
  def styling
    #unless style = PageStyle.where(id: self.page_style_id).first
    #  style = 
  end
  
  def user_activities
    self.wall_posts.where(user_id: self.id)
  end
  
  # just before the user is destroyed the following models are updated
  def sanitize_relations
    # messages
    if send_messages       = Message.where(sender_id: self.id)
      send_messages.update_all(sender_removed: true)
    end
    
    if received_messages   = Message.where(recipient_id: self.id)
      received_messages.update_all(recipient_removed: true)
    end
    
    #client_ids          = Client.where(member_id: self.id).pluck(:id)
    #if client_invitations  = ClientInvitation.where(client_id: client_ids)
    #  client_invitations.destroy_all
    #end
    
    if clients             = Client.where(member_id: self.id)    
      clients.update_all(member_id: nil)
    end

    self.recordings.update_all( user_id: User.system_user.id, 
                                privacy: 'Only me'
                              )
    
   
    
    if shop_orders = Shop::Order.where(user_id: self.id)
      shop_orders.update_all(user_id: nil)
    end
    
    if shop_products = Shop::Product.where(user_id: self.id)
      shop_products.update_all(user_id: nil, account_id: nil, document_id: nil)
    end
    
    if self.stripe_transfers
      self.stripe_transfers.update_all(user_id: nil, shop_order_id: nil )
    end
    
    unless self.mandrill_account_id.blank?
      DeleteUserMandrillAccountJob.perform_later(self.mandrill_account_id)
    end

    # other users following this user
    if followed_events = FollowerEvent.where(postable_type: 'User', postable_id: self.id)
      followed_events.destroy_all
    end
    
    self.account_users.destroy_all
    
    if self.user_configuration
      self.user_configuration.destroy
    end
    
    if self.address
      self.address.destroy
    end
    


    self.common_work_ipis.find_each do |common_work_ipi|
      common_work_ipi.update_attributes(
        ipi_id: nil,
        user_id: nil,
        publishing_agreement_id: nil,
        publisher_id: nil,
        ipi_publisher_id: nil,
        status: 0
      )
    end
    
    if self.user_publishers
      user_publishers.destroy_all
    end
    
    if client_invitations = ClientInvitation.where(client_id: self.id)
      client_invitations.destroy_all
    end
    
  end
  
  def self.system_user
    if user= User.where(email: 'digiramp_system_default_957@digiramp.com').first
    
    else
      user = User.create( email: 'digiramp_system_default_957@digiramp.com', 
                          name:  'digiramp_system_default_957', 
                          user_name: 'digiramp_system_default_957', 
                          #current_account_id: @account.id, 
                          password: '5GA3Zk1C', 
                          password_confirmation: '5GA3Zk1C',
                          activated: true,
                          private_profile: true)
                                              
      create_account_for user
    end
    user
  end
 
  def unread_messages
    self.received_massages.where(read: false, recipient_removed: false).count
  end
  
  
  def setup_basics
    set_token
    self.uuid                  = UUIDTools::UUID.timestamp_create().to_s
    self.uniq_followers_count  = "0".to_uniq
    self.page_style_id         = PageStyle.plain_style.id
    
  end
  
  
  def update_meta
    UserSearchField.process self
    UserCompleteness.process self
    SetUserTopTag.process self
  end

  def set_token
    generate_token(:auth_token)
  end

  def set_default_relations
    
    EmailGroup.find_each do |email_group|

      if email_group.subscription_by_default?
        ms = MailListSubscriber.create( user_id: self.id,
                                   email_group_id: email_group.id )

      end
        
    end
    Client.where(email: self.email).update_all(member_id: self.id)
    #set_default_avatar
    CreateUserMandrillAccountJob.perform_later(self.id) if Rails.env.production?
    Stake.where(  email: self.email ).update_all( unassigned: false)
    
    UserConfiguration.create(user_id: self.id)

    
    SlackService.user_signed_up(self) if Rails.env.production?
    
    update_meta
    
    #ProfessionalInfo.create(user_id: self.id)
  end

  def stripe_customers
    StripeCustomer.where(stripe_id: self.stripe_customer_id )
  end
  

  
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    unless other_user.id == self.id
      begin
        _relation_ship = self.relationships.create!(followed_id: other_user.id)
        self.update_columns(
          follow_other_users: self.relationships.count > 0
        )
        return _relation_ship
      rescue
        ap 'bang'
        Opbeat.capture_message("User::Line 544 #{ { self_id: self.id , other_user_id: other_user.id} }")
      end
    end
  end
  
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
    self.update_columns(
      follow_other_users: self.relationships.count > 0
    )
  end

  def set_propperties
    flush_cache
  end
  
  # create module for this
  # same in catalog
  
  # when is this ever used ?
  # where is it used from ?
  # could be usefull for handling over all recordings for a user 
  def update_widget
    default_playlist.add_items self.recordings
  end
  
  def default_widget 
    default_playlist.default_widget
  end
  
  # add parameters to this
  def default_playlist
    Playlist.where( uuid: self.uuid)
            .first_or_create( uuid:       self.uuid,
                              user_id:    self.id,
                              account_id: self.account.id,
                              title:      self.get_full_name,
                              #body:       self.body,
                              url:        UUIDTools::UUID.timestamp_create().to_s,
                              url_title:  self.get_full_name,
                              link_title: self.get_full_name
                            )


  end

  ## !!!! should be depricated! Moved to AccountUser
  def can? action, id_name_or_record, _account_id
    logger.info 'OBSOLETE: user / can?'
    return true
  end 

  def send_password_reset
    self.add_token
    UserMailer.delay.password_reset(self.id)
  end 
  

  
  
  def current_account
    
    begin
      return  Account.cached_find(self.current_account_id)
    rescue
      if current_account = Account.where(user_id: self.id).first
        save!
        return current_account
      else
        render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
      end
    end
  end
  
  def default_account

    if self.account_users.size > 1
      self.account_users.each do |account_user|
        return account_user.account unless account_user.account.account_type == 'business'
      end
    end

    account_users.first.account
  end
  
  def super?
    self.role == 'Super'
  end
  
  def editor?
    self.role == 'Backend Editor'
  end
  
  def can_edit?
    self.role == 'Super'
  end
  
  def manage? user
    return false unless user
    return true if user.super?
    return true if user.id == self.id
    false
  end
  
  def get_full_name
    self.full_name ? self.full_name : self.user_name
  end

  def get_account_id
    self.account.id
  end
  
  def permission_cache_for account
    begin
      return AccountUser( account.id, self.id).permission_key
    rescue
      return UUIDTools::UUID.timestamp_create().to_s
    end
  end
  
  def can_administrate acct
    return true if acct.administrator_id == self.id
    return true if self.super?
    return true if self.account.id == acct.id
    false
  end
  
  def user_role_on account
    if account_user = AccountUser.cached_where( account.id, self.id)
      return account_user.role
    end
    'no access'
  end
  
  
  #def setup_personal_publishing
  #  CopyMachine.setup_personal_publishing self.id
  #end
  
  def pro_affiliation() 
    
    if pub = Publisher.find_by(user_id: self.id, personal_publisher: true)
      pub.pro_affiliation_id 
    end
  
  end
    
  def pro_affiliation=( code)
    personal_publisher.update(pro_affiliation_id: code)
  end
  
  def personal_publisher_ipi_code
    begin
      return personal_publisher.ipi_code 
    rescue => e
      ErrorNotification.post_object 'User#personal_publisher_ipi_code', e
    end
    nil
  end
  
  def personal_publisher_ipi_code=( code)
    personal_publisher.update(ipi_code: code)
  end
  
  def personal_publisher
    Publisher.find_by( user_id: self.id, id: self.personal_publisher_id, personal_publisher: true )
  end
  
  def exclusive_publisher
    if publisher = Publisher.find_by(email: self.exclusive_publishers_email)
      return publisher
    end
  end
  
  def publishing_agreement
    if publisher = get_publisher
      publisher.publishing_agreement.where()
    end
  end
  
  def personal_publishing_agreement
    begin
      if publishing_agreement = PublishingAgreement.find_by(personal_agreement: true, publisher_id: personal_publisher.id)
        return publishing_agreement
      else
        ErrorNotification.post "#{self.user_name} has no personal_publishing_agreement"
        return nil
      end
    rescue => e
      ap e.inspect
    end
    nil
  end
  
  def personal_publishing_agreement_document
    if personal_publishing_agreement
      if document = personal_publishing_agreement.document
        return document
      end
    end
  end
  
  def personal_publishing_agreement_document_user
    if document = personal_publishing_agreement_document
      if document_user = personal_publishing_agreement_document.document_users.where(user_id: self.id).first
        return document_user
      end
    end
  end
  
  
  
  # return the publisher based on publihing type
  def get_publisher
    #case self.personal_publishing_status
    #when "I own and control my own publishing"
    #  personal_publisher
    #when "I have an exclusive publisher"
    #  exclusive_publisher
    #else
    #  nil
    #end
  end
  
  # Return the publisher id or nil
  def get_publisher_id
    #if pub = get_publisher
    #  return pub.id
    #end
    nil
  end
  
  #def publishing_administrator_email()  personal_publisher.administrator_email end
  #def publishing_administrator_email=(administrator_email)
  #  administrator = User.get_by_email(administrator_email) 
  #  personal_publisher.update(
  #    publishing_administrator_email: administrator_email,
  #    publishing_administrator_user_id: administrator.id
  #  )
  #end
  
  def publishing_administrator() User.cached_find( personal_publisher.publishing_administrator_user_id ) end

  
  
  
  def publishing_agreement_document() end
  def publishing_agreements() PublishingAgreement.where(account_id: self.account.id) end
  def get_publishing_agreements() account.get_publishing_agreements end
  #def ipi() Ipi.find_by( user_id: self.id,  master_ipi: true) end
  
 
  def label
    begin
      unless _label = Label.find_by(id: self.default_label_id )
        _label = Label.create_label( self.account.id)
      end
      return _label
    rescue => e
      ErrorNotification.post_object 'User#label', e
      return nil
    end
  end
  
  def personal_distribution_agreement
     label.default_distribution_agreement if label
  end
  
  
  
  def legal_informations_completed?
    return false if self.address.first_name.blank?
    return false if self.address.last_name.blank?
    return false if self.address.address_line_1.blank?
    return false if self.address.city.blank?
    return false if self.address.country.blank?
    return false if self.address.zip_code.blank?
    true
  end
  
  
  
  
  
  
  
  
  def self.search query 
    if query.present?
      return User.search_user(query)
    else
      return all
    end
  end
  
  
  
  def self.cached_find_by_auth_token( auth_token)
    Rails.cache.fetch([name, auth_token]) { User.find_by_auth_token( auth_token)  }
    
  end
  
  def flush_auth_token_cache auth_token
    Rails.cache.delete([self.class.name, auth_token])
  end
  
  
  def self.to_csv
    CSV.generate do |csv|

      #csv << column_names
      csv << ['Id','Name', 'Email', 'Role', 'Account Id', 'Activated' ]
      
      all.each do |user|
        csv << [  user.id.to_s, 
                  user.name, 
                  user.email,
                  user.role,
                  user.account.id.to_s,
                  user.activated.to_s
                ]
      end

    end
  end
  
  
  def self.create_account_for user
    
    Account.where(
                    contact_email: user.email,
                    title: user.email,
                    user_id: user.id
                  )
            .first_or_create(  title: user.email, 
                               account_type: 'Social', 
                               contact_email: user.email, 
                               user_id: user.id,
                               expiration_date: Date.current()>>1
                            )

  end
  
  
  
  def self.invite_to_catalog_by_email email, title, body, catalog_id
    ap 'User.invite_to_catalog_by_email not implemented'
  end
  

  # Check if there is a user with the email if not create a niw one
  def self.find_or_create_from_email email

    if user = User.get_by_email( email )
      return user
    end
    create_from_email email 
  end
  
  def self.create_user_with_account email
    create_from_email email
  end
  
  # invite a create a new user based on an email 
  def self.create_from_email email
    
    if email = EmailSanitizer.saintize( email )
      user_name = create_uniq_user_name_from_email email
      
      secret_temp_password  = UUIDTools::UUID.timestamp_create().to_s
      user                  = User.create(    
                                          user_name:      user_name,
                                              email:      email, 
                                            invited:      true, 
                                           password:      secret_temp_password, 
                              password_confirmation:      secret_temp_password,
                                  account_activated:      false,
                                    private_profile:      true
                                          )
      DefaultAvararJob.perform_later user.id                   
      # apply a password reset token
      user.add_token
      
      # create an account
      UserAssetsFactory.new user

      # return the new user
      return user
    end
    false
  end
  
  def self.create_uniq_user_name_from_email email
    
    begin
      user_name = email.split('@').first
    rescue
      user_name = 'no_name'
    end
    
    user_name.capitalize!
    
    if usr = User.where(user_name: user_name).first
      if last_user = User.last
        user_name = [ user_name, last_user.id.to_s].compact.join('_')
      end
    end
    user_name
  end
  
  def connections_count
    Connection.where("user_id = ?  OR connection_id = ?" , self.id, self.id).count
  end
  
  # Send notification to an existing user
  def send_notification options={}
    ap '-- send_notification --'
    ap options
  end
  
  # send an infvitation to a new user
  def self.send_invitation options={}
    ap '-- send_invitation --'
    ap options
  end
  

  
  # find or create a user 
  # and send an email invitation
  
  def self.invite_to_account_by_email email, title, body, account_id, current_user_id
    
    
    sanitized_email = EmailSanitizer.saintize email

    # the user is already signed up
    if found_user       = User.where(email: sanitized_email).first
      
      # invite found user to account
      UserMailer.delay.invite_existing_user_to_account found_user.id, title, body

    else
      # create user
      #user_name = User.create_uniq_user_name_from_email(email)
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      new_user = User.create( email:                  sanitized_email, 
                              name:                   create_uniq_user_name_from_email(sanitized_email),
                              user_name:              create_uniq_user_name_from_email(sanitized_email),
                              invited:                true, 
                              password:               secret_temp_password, 
                              password_confirmation:  secret_temp_password,
                              role:                   'Customer'
                                
                            )
      
      # apply a password reset token
      new_user.add_token
      
      # create account
      UserAssetsFactory.new new_user

      # invite to existing new to catalog
      UserMailer.delay.invite_new_user_to_account( new_user.id , title, body )
      found_user = new_user
    end
    found_user
  end

  def add_token
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
  end
  
  def name_or_email
    return  name == '' ? email : name
  end
  
  def has_access_to_cattalogs_on account
    CatalogUser.find_by(catalog_id: account.catalog_ids, user_id: self.id)
  end
  
  def self.cached_find(id)
    begin
      case id.class.name
      when "String"
        return Rails.cache.fetch([name, id]) { friendly.find(id) }
      #when "User"
      #  return User.friendly.find(id.id)
      when "Fixnum"
        return Rails.cache.fetch([name, id]) { find(id) }
      end
    rescue ActiveRecord::RecordNotFound => e
      message = "User: #{id} not found"
      #ErrorNotification.post_object message, e
    end
    nil
  end
  
  #def set_go_to go_to_url
  #  ap @go_to_url = go_to_url
  #end
  #
  #def get_google_url
  #  @go_to_url
  #end
  
  def facebook
    
    if provider = authorization_providers.find_by(provider: 'facebook')
      @facebook ||= Koala::Facebook::API.new(provider.oauth_token)
      block_given? ? yield(@facebook) : @facebook
    else #Koala::Facebook::APIError
      
      return nil
    end
    @facebook
  end
  
  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end
  
  def facebook_publish_actions
    if facebook
      begin
        permissions                         = facebook.get_connection("me", "permissions")
        publish_actions_permission          = permissions.find { |permission| permission["permission"] == "publish_actions" }
        publish_actions_permission_granted  = publish_actions_permission && publish_actions_permission["status"] == "granted"
        return publish_actions_permission_granted
      rescue
        return false
      end
    else
      return false
    end
  end
  
  def set_has_shared_a_recording
    return if self.has_shared_a_recording
    
    if !self.share_on_facebooks.blank? || !self.share_on_twitters.blank?
      self.update(has_shared_a_recording: true)
    end
    
  end
  
  def set_has_invited_friends
    begin
      return if self.user_configuration.has_invited_friends
      if !self.client_invitations.blank?
        self.user_configuration.update(has_invited_friends: true)
      end
    rescue
    end
  end
  
  
  def attach_common_work_ipis_to_personal_publisher

    self.common_work_ipis.each do |common_work_ipi|
      common_work_ipi.common_work_ipi_publishers.destroy_all
    end
    
    self.common_work_ipis.each do |common_work_ipi|
      CommonWorkIpiPublisher.create(
        common_work_ipi_id:             common_work_ipi.id,
        publisher_id:                   personal_publisher.id,
        publishing_agreement_id:        personal_publishing_agreement.id,
        publishing_split:               0.0,
        user_id:                        self.id
      )

    end
  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, self.slug])
  end

private

  def get_record_class id_name_or_record
    return id_name_or_record if id_name_or_record.kind_of? String
    case class_name = id_name_or_record.class.to_s
    when "Playlist", "MusicOpportunity" then class_name
    end
  end
  

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
