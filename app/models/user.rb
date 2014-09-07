# a user can be created by someone else than the user
# E:G: an other user can add the user as a client to his account.
# In that case there is send no notification to the user
# and the user is marked as not signed up
# account users with the role 'Client' can not se the accounts where they are clients


class User < ActiveRecord::Base
  has_secure_password
  include PublicActivity::Common
  
  include PgSearch
  pg_search_scope :search_user, against: [:name, :email, :profile], :using => [:tsearch]
  
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  validates_presence_of :name, :on => :update
  before_create :set_uuid

  
  serialize :crop_params, Hash
  mount_uploader :image, AvatarUploader
  #include ImageCrop
  
  has_one :account_users
  has_many :account_users
  
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
  
  has_many :activity_events, as: :activity_eventable
  
  after_save :update_access
  after_commit :set_propperties
  
  before_save :validate_info
  #before_destroy :delete_account
  
  has_many :emails, dependent: :destroy
  
  # statistic on playbacks
  has_many :playbacks
  
  # statistic on likes
  has_many :likes
  
  has_many :playlists
  
  def validate_info
    self.email.downcase!
    if self.name.to_s == ''
      self.name = self.email
    end
  end
  
  #def delete_account
  #  begin
  #    self.account.create_activity(  :destroyed, 
  #                          owner: current_user,
  #                      recipient: self.account,
  #                 recipient_type: self.account.class.name)
  #                 
  #    self.account.destroy!
  #  rescue
  #  end
  #end
  
  

  
  ROLES       = ["Super", "Customer"]
  SECRET_NAME = "RGeiHK8yUB6a"
  
  scope :supers,            ->    { where( role: 'Super' ).order("email asc")  }
  scope :administrators,    ->    { where( administrator: true ).order("email asc")  }
  scope :customers,         ->    { where( role: 'Customer' ).order("email asc")  }
  scope :with_a_collection, ->    { where( has_a_collection: true)}
  
  
  def update_access
    AccessManager.update_access self
  end
  
  def set_propperties

    #SuperUser.update_role self
    flush_cache
    #update_role_on_catalogs
    #update_role_on_accounts
    
  end
  

  
  
  
  # update the uuid to force rebuild of 
  # segment cached pages
  def set_uuid
    generate_token(:auth_token)
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  
  ## !!!! should be depricated! Moved to AccountUser
  def can? action, id_name_or_record, _account_id
    return true
  end 
  
  
  
  
  def send_password_reset
    self.add_token
    UserMailer.delay.password_reset(self.id)
  end 
  

  def invite_existing_user_to_account account_id , invitation_message
    UserMailer.delay.invite_existing_user_to_account self.id, account_id, invitation_message
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
        return account_user.account unless account_user.account.account_type == 'supervisor'
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
    @account = Account.new(   title: user.email, 
                              user_id: user.id, 
                              expiration_date: Date.current()>>1,
                              contact_email: user.email,
                              visits: 1,
                              account_type: 'Personal Account',
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
                                       account_type: Account::ACCOUNT_TYPES[:free_account], 
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
    if user  = User.find_by_email(email)
    else
      user   = User.invite_user( email )
    end
    user
  end
  
  def self.create_user_with_account email
    invite_user email
  end
  
  # invite a user based on an email 
  def self.invite_user email
    secret_temp_password  = UUIDTools::UUID.timestamp_create().to_s
    user                  = User.create(                   
                                             name: email.downcase, 
                                            email: email.downcase, 
                                          invited: true, 
                                         password: secret_temp_password, 
                            password_confirmation: secret_temp_password,
                                account_activated: false
                                        )
                            
     # apply a password reset token
     user.add_token
     
     # create an account
     create_a_new_account_for_the user
     
     # return the new user
     user
  end
  
  
  # find or create a user 
  # and send an email invitation
  def self.invite_to_account_by_email email, title, body, account_id
    
    # the user is already signed up
    if found_user       = User.find_by_email(email.downcase)
      
      # invite found user to account
      UserMailer.delay.invite_existing_user_to_account found_user.id, account_id, body
      #UserMailer.delay.invite_existing_user_to_account( found_user.id , title, body, account_id )
      
      # force uuid to update
      found_user.save!
    else
      # create user
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      found_user = User.create( name: email.downcase, 
                                email: email.downcase, 
                                invited: true, 
                                password: secret_temp_password, 
                                password_confirmation: secret_temp_password
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
      return nil
    end
  end
  
  
  
  
  
  
    
    
    
    

private

  def flush_cache
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
