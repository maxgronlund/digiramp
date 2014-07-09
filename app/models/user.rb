# a user can be created by someone else than the user
# E:G: an other user can add the user as a client to his account.
# In that case there is send no notification to the user
# and the user is marked as not signed up
# account users with the role 'Client' can not se the accounts where they are clients


class User < ActiveRecord::Base
  has_secure_password
  
  include PgSearch
  pg_search_scope :search_user, against: [:name, :email, :profile], :using => [:tsearch]
  
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  validates_presence_of :name, :on => :update
  before_create { generate_token(:auth_token) }
  #before_destroy :delete_accounts
  
  serialize :crop_params, Hash
  mount_uploader :image, AvatarUploader
  #include ImageCrop
  
  has_one :account_users
  has_many :account_users
  
  has_many :catalog_users, dependent: :destroy
  has_many :catalogs, through: :catalog_users
  
  has_one :dashboard
  has_one :account
  
  has_many :account_users, dependent: :destroy
  has_many :work_users, dependent: :destroy
  has_many :works, through: :work_users
  has_many :accounts, :through => :account_users  
  
  #has_many :bugs, dependent: :destroy
  
  
  has_many :ipis
  has_many :issues, dependent: :destroy
  #has_many :permissions
  #has_many :permitted_models, dependent: :destroy #!!! moving to account_user
  
  has_many :activity_events, as: :activity_eventable
  has_many :invites
  
  has_many :representatives, dependent: :destroy
  has_many :search_recordings
  
  # account_catalog a user administrates
  has_many :administrations
  has_many :account_catalogs, through: :administrations
  
  ROLES       = ["Super", "Customer"]
  SECRET_NAME = "RGeiHK8yUB6a"
  
  scope :supers,          ->    { where( role: 'Super' ).order("email asc")  }
  scope :administrators,  ->    { where( administrator: true ).order("email asc")  }
  scope :customers,       ->    { where( role: 'Customer' ).order("email asc")  }
  
  after_commit :flush_cache
  
  # force update of uuid
  # before_save :set_uuid
  
  # update the uuid to force rebuild of 
  # segment cached pages
  def set_uuid
    logger.debug '--------------- set uuid -----------------------'
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  
  ## !!!! should be depricated! Moved to AccountUser
  def can? action, id_name_or_record, _account_id
    return true
  end 
  
  
  
  
  def send_password_reset
    #generate_token(:password_reset_token)
    #self.password_reset_sent_at = Time.zone.now
    #save!
    self.add_token
    UserMailer.delay.password_reset(self)
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


  def asseccible_recordings
    recordings = []
    
    accounts.each do |acnt|
      acnt.recordings.each do |rec|
        recordings << rec
      end
    end
    recordings.uniq
  end
  
  def playlists
    playlists = []
    accounts.each do |account|
      account.playlists.each do |playlist|
        playlists << playlist
      end
    end
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
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
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
                            )
                            
    # save the account without validation                        
    @account.save(validate: false)    
    
    # creating the account user                 
    account_user = AccountUser.create(user_id: user.id, 
                                      account_id: @account.id, 
                                      role: 'Account Owner')
    # give the account user permissions                                  
    account_user.grand_basic_permissions
    
    # limit user invite
    #account_user.createx_user  = false
    #account_user.read_user     = false
    #account_user.update_user   = false
    #account_user.delete_user   = false
    #account_user.save!
    
    # set the account owned by the user
    user.account_id          = @account.id
    
    # store the account
    user.current_account_id  = @account.id
    
    # save
    user.save!
    
    # return the account
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
    #if found_user       = User.where(email: email).first
    #  # invite to existing user to catalog
    #  UserMailer.delay.invite_existing_user_to_catalog( found_user.id , title, body, catalog_id )
    #  
    #  # force the uuid to update
    #  found_user.save!
    #else
    #  # create user
    #  secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
    #  found_user = User.create( name: email, 
    #                            email: email, 
    #                            invited: true, 
    #                            password: secret_temp_password, 
    #                            password_confirmation: secret_temp_password
    #                          )
    #  
    #  # apply a password reset token
    #  found_user.add_token
    #  
    #  # create account
    #  create_a_new_account_for_the found_user
    #
    #  # invite to existing new to catalog
    #  UserMailer.delay.invite_new_user_to_catalog( found_user.id , title, body,  catalog_id )
    #end
    #
    #found_user
  end
  
  # invite a user based on an email 
  def self.invite_user email
    secret_temp_password  = UUIDTools::UUID.timestamp_create().to_s
    user                  = User.create(  name: email, 
                                          email: email, 
                                          invited: true, 
                                          password: secret_temp_password, 
                                          password_confirmation: secret_temp_password
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
    if found_user       = User.where(email: email).first
      
      # invite found user to account
      UserMailer.delay.invite_existing_user_to_account found_user.id, account_id, body
      #UserMailer.delay.invite_existing_user_to_account( found_user.id , title, body, account_id )
      
      # force uuid to update
      found_user.save!
    else
      # create user
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      found_user = User.create( name: email, 
                                email: email, 
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
  
  #def can_manage_assets account
  #  return true if account.create_recording_ids.include?        self.id
  #  return true if   account.read_recording_ids.include?        self.id
  #  return true if account.update_recording_ids.include?        self.id
  #  return true if account.delete_recording_ids.include?        self.id
  #  return true if account.create_recording_ipi_ids.include?    self.id
  #  return true if   account.read_recording_ipi_ids.include?    self.id
  #  return true if account.update_recording_ipi_ids.include?    self.id
  #  return true if account.delete_recording_ipi_ids.include?    self.id
  #  return true if account.create_file_ids.include?             self.id
  #  return true if   account.read_file_ids.include?             self.id
  #  return true if account.update_file_ids.include?             self.id
  #  return true if account.delete_file_ids.include?             self.id
  #  return true if account.create_common_work_ids.include?      self.id
  #  return true if   account.read_common_work_ids.include?      self.id
  #  return true if account.update_common_work_ids.include?      self.id
  #  return true if account.delete_common_work_ids.include?      self.id
  #  return true if account.create_common_work_ipi_ids.include?  self.id
  #  return true if   account.read_common_work_ipi_ids.include?  self.id
  #  return true if account.update_common_work_ipi_ids.include?  self.id
  #  return true if account.delete_common_work_ipi_ids.include?  self.id
  #  return false
  #end
  #
  #def can_manage_users account
  #  return true if account.create_account_user_ids.include?     self.id
  #  return true if account.read_account_user_ids.include?       self.id
  #  return true if account.update_account_user_ids.include?     self.id
  #  return true if account.delete_account_user_ids.include?     self.id
  #  return false
  #end
  
  
  

private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    
    #AccountUser.where(user_id: id).each do |account_user|
    #  account_user.save
    #end
    
    #Rails.cache.delete([self.class.name, id,  cookies[:auth_token] ]) 
  end

  
  #def has_permission_for_record? action, record
  #  ## This could be rewritten to a single sql query
  #  permissions
  #  .where(permissionable_type: record.class.to_s, permissionable_id: record.id)
  #  .each do |permission|
  #    return true if permission.permitted_actions.exists?(permitted_action: action)
  #  end
  #  
  #  false
  #end
  
  #def has_permission_for_model? action, id_name_or_record, _account_id
  #  if record_class = get_record_class(id_name_or_record)
  #    account_users.each do |account_user|
  #      return true if account_user.has_permission_for_model? action, record_class, _account_id
  #    end
  #  end
  #  
  #  false
  #end
  
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
