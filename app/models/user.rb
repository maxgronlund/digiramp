class User < ActiveRecord::Base
  has_secure_password
  
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  before_create { generate_token(:auth_token) }
  #before_destroy :delete_accounts
  
  serialize :crop_params, Hash
  mount_uploader :image, AvatarUploader
  include ImageCrop
  
  has_one :account #
  #has_many :account_users
  
  has_one :dashboard
  
  
  has_many :account_users, dependent: :destroy
  has_many :accounts, :through => :account_users  
  has_many :bugs, dependent: :destroy
  
  
  has_many :ipis
  #has_many :permissions
  #has_many :permitted_models, dependent: :destroy #!!! moving to account_user
  
  has_many :activity_events, as: :activity_eventable
  has_many :invites
  
  has_many :representatives, dependent: :destroy
  has_many :search_recordings
  
  # account_catalog a user administrates
  has_many :administrations
  has_many :account_catalogs, through: :administrations
  
  ROLES = ["super", "cuctomer"]
  
  scope :supers,      ->    { where( role: 'super' ).order("email asc")  }
  
  ## !!!! should be depricated! Moved to AccountUser
  def can? action, id_name_or_record, _account_id
    return true
  end 
  
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.delay.password_reset(self)
  end 
  
  def invite_existing_user_to_account invited_to_account
    
    options = { user: self, account: invited_to_account}
    UserMailer.delay.invite_existing_user_to_account options
    
  end
  
  def invite_to_account( account_id , invitation_message)
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.delay.invite_to_account(self.id, account_id, invitation_message)
  end

  def send_signup_confirmation
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.delay.signup_confirmation(self)
  end
  
  def new_account_and_user_confirmation  invited_to_account
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    options = { user: self, account: invited_to_account}
    UserMailer.delay.new_account_and_user_confirmation options
  end
  
  def signed_up_and_invited_to account_id, invitation_massage

    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.delay.signup_confirmation self.id, account_id, invitation_massage 
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
    
    return  Account.find(self.current_account_id) if  Account.exists?(self.current_account_id)
    #account_user = AccountUser.where(user_id: self.id).first
    #
    #return Account.find(account_user.account_id) if account_user
    
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
    self.role == 'super'
  end
  
  def can_edit?
    self.role == 'super'
  end
  
  #def admin_or_super?
  #
  #  #!!! do some permissions here
  #  #begin
  #  #  account_user = AccountUser.find(user.current_account_id)
  #  #  return account_user.admin_or_super?
  #  #rescue
  #  #  return false
  #  #end
  #end
  
  def can_administrate account
    return true if account.id == self.account_id
    return true if user_role_on( account) == 'Administrator'
    return true if self.super?
    false
  end
  
  def user_role_on account
    if account_user = AccountUser.where(user_id: self.id, account_id: account.id).first
      return account_user.role
    end
    'no access'
  end
  
  #def has_permission_for? action, permitted_model_id_name, _account_id
  #
  #  if permitted_model_type = PermittedModelType.where(id_name: permitted_model_id_name).first
  #    account_user  = AccountUser.where(user_id: self.id, account_id: _account_id).first
  #    return account_user && account_user.has_permission_for?( action, permitted_model_type.id )
  #  end
  #
  #  return false
  #  
  #end
  
  def self.search( query)
    if query.present?
      return User.where("name @@ :q or email @@ :q", q: query)
    else
      return all
    end
  end
  


private
  
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
