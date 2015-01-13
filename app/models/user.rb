## a user can be created by someone else than the user
# E:G: an other user can add the user as a client to his account.
# In that case there is send no notification to the user
# and the user is marked as not signed up
# account users with the role 'Client' can not se the accounts where they are clients


class User < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :user_name, :use => :history
  #friendly_id :user_name, use: :slugged
  
  scope :public_profiles,  ->  { where( private_profile: false)  }
  
  
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
                                    
                                    
  
  validates_uniqueness_of :email
  validates_presence_of   :email, :on => :update
  
  validates_uniqueness_of :user_name
  validates_presence_of   :user_name, :on => :update
  
  validates_presence_of :password, :on => :create
  validates_presence_of :name, :on => :update
  #before_create :set_uuid
  
  has_many :comments,        as: :commentable,          dependent: :destroy
  

  has_many :selected_opportunities
  

  
  serialize :crop_params, Hash
  mount_uploader :image, AvatarUploader
  #include ImageCrop
  
  has_one :account_users
  has_many :account_users
  has_many :recordings
  
  # used to display the users recordings
  has_many :widgets, dependent: :destroy
  
  # omniauth
  has_many :authorization_providers, dependent: :destroy
  
  has_many :catalog_users, dependent: :destroy
  has_many :catalogs, through: :catalog_users
  has_many :opportunity_users, dependent: :destroy
  has_many :opportunities, through: :opportunity_users
  
  #################################
  # not sure if in use
  has_one :dashboard
  has_many :work_users,       dependent: :destroy
  has_many :works, through: :work_users
  has_many :invites
  
  # account_catalog a user administrates
  has_many :administrations
  has_many :account_catalogs, through: :administrations
  #################################
  
  has_one  :account
  has_many :account_users,    dependent: :destroy
  has_many :accounts, :through => :account_users  
  
  # for the crm
  has_many :project_tasks
  has_many :projects
  
  
  has_many :ipis
  has_many :issues, dependent: :destroy
  
  #has_many :permissions
  #has_many :permitted_models, dependent: :destroy #!!! moving to account_user
  # Activities
  has_many :activity_events, as: :activity_eventable
  
  has_many :share_on_facebooks, dependent: :destroy
  has_many :share_on_twitters, dependent: :destroy
  
  after_save :update_access
  after_commit :set_propperties
  
  before_save   :validate_info
  before_create :set_token
  before_create :validate_info
  before_destroy :sanitize_relations
  after_create :set_default_avatar
  
  has_many :emails, dependent: :destroy
  
  # statistic on playbacks
  has_many :playbacks
  has_many :recording_views
  
  # statistic on likes
  has_many :likes
  
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
  
  has_many :forums, dependent: :destroy
  
  def user_activities
    self.wall_posts.where(user_id: self.id)
  end
  
  def short_email
    short_email = self.email.slice(0...24)
    short_email << '...' if self.email.size > 24
    short_email
  end
  
  def sanitize_relations
    # messages
    send_messages       = Message.where(sender_id: self.id)
    send_messages.update_all(sender_removed: true)
    
    received_messages   = Message.where(recipient_id: self.id)
    received_messages.update_all(recipient_id: true)
    
    self.recordings.each do |recording|
      recording.user_id = User.system_user.id
      recording.privacy = 'Only me'
      recording.save!
    end
    
  end
  
  def self.system_user
    
    if user= User.where(email: 'digiramp_system_default_957@digiramp.com').first
    
    else
      user = User.create( email: 'digiramp_system_default_957@digiramp.com', 
                           name:  'digiramp_system_default_957', 
                           #current_account_id: @account.id, 
                           password: '5GA3Zk1C', 
                           password_confirmation: '5GA3Zk1C',
                           activated: true,
                           private_profile: true)
                           
      create_account_for user
    end
    user
  end
  
  def update_search_field
    search_field_content = ''
    search_field_content <<   self.profession  if self.profession
    search_field_content <<  ' '
    
    search_field_content <<   self.name        if self.name
    search_field_content <<  ' '
    
    search_field_content <<   self.email       if self.email
    search_field_content <<  ' '
    
    search_field_content <<   self.user_name  if self.user_name
    search_field_content <<  ' '
    
    search_field_content <<  'writer '        if self.writer
    search_field_content <<  'author '        if self.author
    search_field_content <<  'producer '      if self.producer
    search_field_content <<  'composer '      if self.composer
    search_field_content <<  'remixer '       if self.remixer
    search_field_content <<  'musician '      if self.musician
    search_field_content <<  'dj '            if self.dj
    search_field_content <<  'country '       if self.country
    search_field_content <<  'city '          if self.city
    search_field_content <<  'artist '        if self.artist
    self.search_field = search_field_content
  end
  
  def set_token
    generate_token(:auth_token)
  end
  
  def unread_messages
    self.received_massages.where(read: false, recipient_removed: false).count
  end
  
  
  def validate_info
    
    # always start as a customer
    self.role = 'Customer' if self.role.to_s == ''
    
    if EmailValidator.saintize( self.email )
      self.user_name = User.create_uniq_user_name_from_email(self.email)    if self.user_name.to_s  == ''
      self.name      = user_name                                            if self.name.to_s       == ''
      self.first_name = user_name.split('@').first                          if self.first_name.to_s == ''
      self.last_name = user_name.split('@').last.gsup('_', '')              if self.first_name.to_s == ''
      self.uuid      = UUIDTools::UUID.timestamp_create().to_s              if self.uuid.to_s       == ''
    end
    
    #self.uniq_completeness    = Uniqifyer.uniqify(self.completeness)
    update_completeness
    update_search_field
    
    self.uniq_followers_count = Uniqifyer.uniqify(self.followers_count)
    
  end
  

  
  def set_default_avatar
    
    if self.image_url.include?("/assets/fallback/default" )
      prng      = Random.new
      random_id =  prng.rand(12)

      if random_id < 10
        random_id = '0' + random_id.to_s 
      end
      
      self.image = File.open(Rails.root.join('app', 'assets', 'images', "default-avatars/avatar_#{random_id.to_s}.jpg"))
      self.image.recreate_versions!
      self.save!
    end
  end
  

  
  def update_completeness
    
    nr_required_params   = 0.0
    completeness         = 0.0
    default_name        = User.create_uniq_user_name_from_email(self.email)
    
    # user name is still default name
    completeness        += 1 unless self.name               == default_name
    nr_required_params  += 1                                                                    
                                                            
    # user user_name is still default name                                                                                            
    completeness        += 1 unless self.user_name          == default_name
    nr_required_params  += 1    
    
    completeness        += 1 unless self.profile.to_s       == ''
    nr_required_params  += 1 
    
    completeness        += 1 unless self.profession.to_s    == ''
    nr_required_params  += 1  
    
    completeness        += 1 unless self.country.to_s       == ''
    nr_required_params  += 1   
    
    completeness        += 1 unless self.city.to_s          == ''
    nr_required_params  += 1    
    
    completeness        += 1 unless self.image.to_s    == ''
    nr_required_params  += 1    
      
    self.completeness     = (completeness / nr_required_params * 100).to_i
    
    #self.uniq_completeness = Uniqifyer.uniqify(self.completeness)

    #artist        
    #author
    #composer
    #writer
    #
    #musician
    #producer
    #remixer
    #dj
  end
  

  
  ROLES       = ["Super", "Customer"]
  SECRET_NAME = "RGeiHK8yUB6a"
  
  scope :supers,            ->    { where( role: 'Super' ).order("email asc")  }
  scope :administrators,    ->    { where( administrator: true ).order("email asc")  }
  scope :customers,         ->    { where( role: 'Customer' ).order("email asc")  }
  scope :with_a_collection, ->    { where( has_a_collection: true)}
  
  
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end
    
  def update_access
    AccessManager.update_access self
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
                              account_id: self.account_id,
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
  

  def invite_existing_user_to_account account_id , invitation_message, current_user_id
    UserMailer.delay.invite_existing_user_to_account self.id, account_id, invitation_message, current_user_id
  end
  
  def invite_new_user_to_account( account_id , invitation_message)
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    self.add_token
    UserMailer.delay.invite_new_user_to_account(self.id, account_id, invitation_message)
  end


  #def asseccible_recordings
  #  recordings = []
  #  
  #  accounts.each do |acnt|
  #    acnt.recordings.each do |rec|
  #      recordings << rec
  #    end
  #  end
  #  recordings.uniq
  #end
  
  #def playlists
  #  playlists = []
  #  accounts.each do |account|
  #    account.playlists.each do |playlist|
  #      playlists << playlist
  #    end
  #  end
  #end
  

  
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
  
  def can_edit?
    self.role == 'Super'
  end

  # user by?
  def permits? current_user
    # users can access their own profile
    return true if current_user.id == self.id
       
    # super user can access all profiles 
    return true if current_user.role == 'Super'
      
    # no access
    return false
  end
  
  def full_name
    full_name = self.name
    if self.first_name && self.last_name
      full_name = self.first_name + ' ' + self.last_name
    end
    
    full_name
  end
  
 
  
  def permission_cache_for account
    begin
      return AccountUser( account.id, self.id).permission_key
    rescue
      return UUIDTools::UUID.timestamp_create().to_s
    end
  end
  
  def can_administrate account
    return true if account.administrator_id == self.id
    return true if self.super?
    return true if self.account_id == account.id
    false
  end
  
  def user_role_on account
    if account_user = AccountUser.cached_where( account.id, self.id)
      return account_user.role
    end
    'no access'
  end
  

  
  def self.search(  query)
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
    # creating the acount
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
    
    # set the account owned by the user
    user.account_id          = @account.id
    
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
                  #user.profile.to_s.squish,
                  user.account_id.to_s,
                  user.activated.to_s
                ]
      end

    end
  end
  
  
  def self.create_account_for user
    # forget about the expiration date
    
    account = Account.where(
                              contact_email: user.email,
                              title: user.email
                            )
                    .first_or_create(  title: user.email, 
                                       account_type: 'Social', 
                                       contact_email: user.email, 
                                       user_id: user.id,
                                       expiration_date: Date.current()>>1
                                    )
    user.account_id = account.id
    user.save!
    
    AccountUser.create( account_id: account.id, 
                        user_id: user.id, 
                        role: 'Account Owner', 
                        email: user.email,
                        name:  user.name
                       )

    account
  end
  
  
  
  def self.invite_to_catalog_by_email email, title, body, catalog_id

  end
  

  
  def self.find_or_invite_from_email( email)

    unless user   = User.where(email: email).first
      user        = invite_user( email )
    end
    user
  end
  
  def self.create_user_with_account email
    invite_user email
  end
  
  # invite a user based on an email 
  def self.invite_user email
    
    if email = EmailValidator.saintize( email )
      user_name = create_uniq_user_name_from_email email
      
      
      secret_temp_password  = UUIDTools::UUID.timestamp_create().to_s
      user                  = User.create(    
                                          user_name:      user_name,
                                              email:      email, 
                                            invited:      true, 
                                           password:      secret_temp_password, 
                              password_confirmation:      secret_temp_password,
                                  account_activated:      false
                                          )
                              
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
      user_name = no_name
    end
    
    
    if last_user = User.last
      user_name = [ user_name, (last_user.id ).to_s].compact.join('_')
    end
    user_name
  end
  
  
  # find or create a user 
  # and send an email invitation
  
  def self.invite_to_account_by_email email, title, body, account_id, current_user_id
    
    
    sanitized_email = EmailValidator.saintize email

    # the user is already signed up
    if found_user       = User.where(email: sanitized_email).first
      
      # invite found user to account
      UserMailer.delay.invite_existing_user_to_account found_user.id, account_id, body, current_user_id
      #UserMailer.delay.invite_existing_user_to_account( found_user.id , title, body, account_id )
      
      # force uuid to update
      #found_user.save!
    else
      # create user
      #user_name = User.create_uniq_user_name_from_email(email)
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      found_user = User.create( email:                  sanitized_email, 
                                name:                   create_uniq_user_name_from_email(sanitized_email),
                                user_name:              create_uniq_user_name_from_email(sanitized_email),
                                invited:                true, 
                                password:               secret_temp_password, 
                                password_confirmation:  secret_temp_password,
                                role:                   'Customer'
                                
                              )
      
      # apply a password reset token
      found_user.add_token
      
      # create account
      create_a_new_account_for_the found_user

      # invite to existing new to catalog
      UserMailer.delay.invite_new_user_to_account( found_user.id , title, body )
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
    !CatalogUser.where(catalog_id: account.catalog_ids, user_id: self.id).nil?
  end
  
  
  def self.cached_find(id)
    begin
      return Rails.cache.fetch([name, id]) { find(id) }
    rescue
    end
    
    begin
      #return Rails.cache.fetch([name, id]) { find(id) }
      return User.friendly.find(id)
    rescue
      return nil
    end
  end
  
  
  
  
  def facebook
    #ap '------ User # facebook --------'
    begin provider = authorization_providers.where(provider: 'facebook').first
      @facebook ||= Koala::Facebook::API.new(provider.oauth_token)
      block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e #Koala::Facebook::APIError
      ap '******************** User # facebook no aurhorization found  ********************'
      return nil
    end
    @facebook
  end
  
  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end
  
  def facebook_publish_actions
    #ap '---------- User # facebook_publish_actions ----------'
    if facebook
      begin
        permissions                         = facebook.get_connection("me", "permissions")
        #ap '-- permissions --'
        #ap permissions
        publish_actions_permission          = permissions.find { |permission| permission["permission"] == "publish_actions" }
        publish_actions_permission_granted  = publish_actions_permission && publish_actions_permission["status"] == "granted"
        return publish_actions_permission_granted
      rescue
        #ap '****************** User # facebook_publish_actions there was an error ***********************'
        return false
      end
      
      #rescue_from Koala::Facebook::APIError do |exception|
      #  ap '======================= oehy ======================'
      #    if exception.fb_error_type == 190
      #      ap 'password reset - redirect to auth dialog'
      #      ap exception
      #    else
      #      ap "Facebook Error: #{exception.fb_error_type}"
      #    end
      #  end
      #end
    
    else
      #ap '--------------------------'
      #ap 'link facebook account here'
      
      return false
      # do something
    end
    
  end


  def tweet message

    if self.authorization_providers
       
      # get twitter provider
      if provider_twitter = self.authorization_providers.where(provider: 'twitter').first

          client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV['TWITTER_KEY'] 
            config.consumer_secret     = ENV['TWITTER_SECRET'] 
            config.access_token        = provider_twitter[:oauth_token]
            config.access_token_secret = provider_twitter[:oauth_secret]
          end
    
          client.update(message)
      end
    end
    

  end
  
    

private

  # obsolete
  def flush_cache
    logger.info 'OBSOLETE: user / flush_cache'
    Rails.cache.delete([self.class.name, id])
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
