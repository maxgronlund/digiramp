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
  scope :supers,            ->    { where( role: 'Super' ).order("email asc")  }
  scope :administrators,    ->    { where( administrator: true ).order("email asc")  }
  scope :customers,         ->    { where( role: 'Customer' ).order("email asc")  }
  scope :with_a_collection, ->    { where( has_a_collection: true)}
  
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


  has_one :address
  accepts_nested_attributes_for :address
  include AddressMix
  
  has_one  :account
  has_one  :user_configuration
  has_many :account_users
  has_many :accounts,         :through => :account_users  
  
  has_many :user_publishers
  has_many :publishers,       :through => :user_publishers 
  
  has_many :comments,        as: :commentable,          dependent: :destroy
  has_many :digital_signatures 
  has_many :recording_downloads, dependent: :destroy
  has_many :selected_opportunities
  has_many :client_invitations
  has_many :subscriptions
  has_many :recording_ipis
  has_many :client_invitation
  

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
  has_many :work_users,               dependent: :destroy
  has_many :works,                    through: :work_users
  has_many :invites
  
  # account_catalog a user administrates
  has_many :administrations
  has_many :account_catalogs, through: :administrations

  # for the crm
  has_many :project_tasks
  has_many :projects
  
  has_many :ipis
  has_many :user_credits, dependent: :destroy
  has_many :issues,       dependent: :destroy
  

  # Activities
  has_many :activity_events, as: :activity_eventable

  has_many :share_on_facebooks, dependent: :destroy
  has_many :share_on_twitters,  dependent: :destroy
  

  after_commit    :set_propperties
  before_save     :update_meta
  #before_create   :update_meta
  #before_create :set_token
  
  before_create   :setup_basics
  after_create    :set_default_relations
  before_destroy  :sanitize_relations
  
  
  has_many :emails, dependent: :destroy
  
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
  
  def next_up?
    self.user_configuration.next_up?
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
  end
  
  def get_documents
    documents.where(status: [0, 1, 2])
    # enum status: [ :draft, :execution_copy, :executed, :deleted ]
  end
  
  def get_publishing_agreements
    get_documents.publishing_agreements
  end
  
  def liked_by user_id
    ItemLike.find_by(user_id: user_id, like_id: self.id, like_type: self.class.name)
  end
  
  def update_user_likes
    #self.user_likes = ItemLike.where(like_id: self.id, like_type: self.class.name).count
    self.update(user_likes: ItemLike.where(like_id: self.id, like_type: self.class.name).count)
    #self.save(validate: false)
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
    @seller_info ||= get_seller_info
  end
  
  def get_seller_info
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
  
  def has_email test_this_email
    test_this_email.downcase!
    return true if test_this_email == self.email
    return true if self.user_emails.where(email: test_this_email).first
    false
  end
  
  def self.get_by_email get_by_email
    get_by_email.downcase!
    if user =  User.find_by(email: get_by_email)
      return user
    elsif user_email = UserEmail.where(email: get_by_email).first
      return user_email.user if user_email.user
    end 
    nil
  end
  
  def confirm_ips
    #self
    if ipis = Ipi.where(email: self.email, confirmation: 'Missing')
      
      ipis.update_all(user_id: self.id)
      return true
    end
    false
  end
  
  def styling
    #unless style = PageStyle.where(id: self.page_style_id).first
    #  style = 
  end
  
  def user_activities
    self.wall_posts.where(user_id: self.id)
  end
  
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
    
    self.ipis.update_all(user_id: nil)
    
    if shop_orders = Shop::Order.where(user_id: self.id)
      shop_orders.update_all(user_id: nil)
    end
    
    if shop_products = Shop::Product.where(user_id: self.id)
      shop_products.update_all(user_id: nil, account_id: nil)
    end
    
    if self.stripe_transfers
      self.stripe_transfers.update_all(user_id: nil, shop_order_id: nil, shop_order_item_id: nil )
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
  
  #def update_search_field
  #  UserSearchField.process self
  #end
  
  
  
  def unread_messages
    self.received_massages.where(read: false, recipient_removed: false).count
  end
  
  
  def setup_basics
    set_token
    self.uuid                  = UUIDTools::UUID.timestamp_create().to_s
    self.uniq_followers_count  = "0".to_uniq
    self.page_style_id         = PageStyle.deep_blue.id
    update_meta
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
    #ProfessionalInfo.create(user_id: self.id)
  end

  def stripe_customers
    StripeCustomer.where(stripe_id: self.stripe_customer_id )
  end
  
  #def update_completeness
  #  UserCompleteness.process self
  #end
  

  
  ROLES       = ["Super", "Customer", "Backend Editor"]
  SECRET_NAME = "RGeiHK8yUB6a"
  

  
  
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    unless other_user.id == self.id
      begin
        self.relationships.create!(followed_id: other_user.id)
      rescue
        Opbeat.capture_message("User::Line 544 #{ { self_id: self.id , other_user_id: other_user.id} }")
      end
    end
  end
  
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
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
                              title:      self.full_name,
                              #body:       self.body,
                              url:        UUIDTools::UUID.timestamp_create().to_s,
                              url_title:  self.full_name,
                              link_title: self.full_name
                            )


  end
  
  
  # end of module
  
  
  

  
  # update the uuid to force rebuild of 
  # segment cached pages
  # 
  def set_uuid
    puts '==============================================='
    puts 'ERROR'
    puts 'User#set_uuid is outdated'
    puts '==============================================='
    
    #self.uuid = UUIDTools::UUID.timestamp_create().to_s
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

  # user by?
  def permits? current_user
    # users can access their own profile
    return true if current_user.id == self.id
       
    # super user can access all profiles 
    return true if current_user.role == 'Super'
    # no access
    false
  end
  
  #def full_name
  #  full_name = self.user_name
  #  if self.first_name && self.last_name
  #    full_name = self.first_name +  ' ' +self.last_name
  #  end
  #  full_name
  #end
  #
 
  
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
  
  def self.create_a_new_account_for_the user
    #return user.account if user.account
    @account = Account.new(   title: user.user_name, 
                              user_id: user.id, 
                              expiration_date: Date.current()>>1,
                              contact_email: user.email,
                              visits: 1,
                              account_type: 'Social',
                              administrator_id: user.id,
                              create_opportunities: false,
                              read_opportunities: false
                            )
                            
    # save the account without validation                        
    @account.save(validate: false)    

    AccessManager.add_users_to_new_account @account
    
    # store the account
    user.current_account_id  = @account.id
    
    # save
    user.save!
   
    @account
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
  

  
  def self.find_or_create_from_email email

    if user = User.get_by_email( email )
      return user
    end
    create_from email 
  end
  
  def self.create_user_with_account email
    create_from email
  end
  
  # invite a user based on an email 
  def self.create_from email
    
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
      create_a_new_account_for_the user
      
      
      
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
    
    #if fo = User.where(user_name: user_name).first
    #  if last_user = User.last
    #    user_name = [ user_name, (last_user.id ).to_s].compact.join('_')
    #  end
    #end
    user_name
  end
  
  def connections_count
    Connection.where("user_id = ?  OR connection_id = ?" , self.id, self.id).count
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
      create_a_new_account_for_the new_user

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
  
  

  def facebook
    if provider = authorization_providers.where(provider: 'facebook').first
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
  


private

  # obsolete
  def flush_cache
    #logger.info 'OBSOLETE: user / flush_cache'
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, self.slug])
  end

  
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
