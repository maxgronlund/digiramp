class Account < ActiveRecord::Base
  
  belongs_to :user
  
  
  #after_create :assign_permissions
  #after_create :validate_expiration_date
  
  has_many :attachments, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :common_works, dependent: :destroy
  #has_many :customers
  has_many :customer_event
  has_many :recordings, dependent: :destroy
  has_many :import_batches
  has_many :catalogs, dependent: :destroy
  has_many :catalog_users
  
  #has_many :representatives, dependent: :destroy
  #has_many :albums
  #has_many :documents, dependent: :destroy
  #has_many :music_opportunities
  #has_many :music_oppertunity_submitions
  #has_many :notifications
  #has_many :common_works_imports
  #has_many :songs
  #has_one :activity_log
  #has_many :account_catalogs, dependent: :destroy
  #has_many :activity_events, as: :activity_eventable
  #has_many :invites
  #has_many :import_ipis
  #after_create :init_activity_log
  
  
  #belongs_to :user
  #accepts_nested_attributes_for :user
  has_many :account_users, dependent: :destroy
  has_many :users, :through => :account_users
  
  # white list user id
  serialize :permitted_user_ids,                    Array                     

  serialize :create_recording_ids,                  Array
  serialize :read_recording_ids,                    Array
  serialize :update_recording_ids,                  Array
  serialize :delete_recording_ids,                  Array

  serialize :create_recording_ipi_ids,              Array
  serialize :read_recording_ipi_ids,                Array
  serialize :update_recording_ipi_ids,              Array
  serialize :delete_recording_ipi_ids,              Array

  serialize :create_file_ids,                       Array
  serialize :read_file_ids,                         Array
  serialize :update_file_ids,                       Array
  serialize :delete_file_ids,                       Array

  serialize :create_legal_document_ids,             Array
  serialize :read_legal_document_ids,               Array
  serialize :update_legal_document_ids,             Array
  serialize :delete_legal_document_ids,             Array

  serialize :create_financial_document_ids,         Array
  serialize :read_financial_document_ids,           Array
  serialize :update_financial_document_ids,         Array
  serialize :delete_financial_document_ids,         Array

  serialize :create_common_work_ids,                Array
  serialize :read_common_work_ids,                  Array
  serialize :update_common_work_ids,                Array
  serialize :delete_common_work_ids,                Array

  serialize :create_common_work_ipi_ids,            Array
  serialize :read_common_work_ipi_ids,              Array
  serialize :update_common_work_ipi_ids,            Array
  serialize :delete_common_work_ipi_ids,            Array
  
  serialize :create_account_user_ids,               Array
  serialize   :read_account_user_ids,               Array
  serialize :update_account_user_ids,               Array
  serialize :delete_account_user_ids,               Array
  
  serialize :create_catalog_ids,                    Array
  serialize   :read_catalog_ids,                    Array
  serialize :update_catalog_ids,                    Array
  serialize :delete_catalog_ids,                    Array
  
  serialize :create_playlist_ids,                    Array
  serialize   :read_playlist_ids,                    Array
  serialize :update_playlist_ids,                    Array
  serialize :delete_playlist_ids,                    Array
  
  serialize :create_crm_ids,                         Array
  serialize   :read_crm_ids,                         Array
  serialize :update_crm_ids,                         Array
  serialize :delete_crm_ids,                         Array

  
  ACCOUNT_TYPES =  ['Personal Account', 'Pro Account','Enterprise Account']
  
  scope :supers,              ->    { where( role: 'super' ).order("email asc")  }
  scope :administrators,      ->    { where( role: 'administrator' ).order("email asc")  }
  

  
  #has_many :recording_imports, dependent: :destroy
  #has_many :documents, as: :documentable, dependent: :destroy
  validates_presence_of :title, :on => :update
  
  #ACCOUNT_TYPES = [ 'catalog owner', 'representative', 'supervisor', 'administrator', 'free account', 'not confirmed']
  
  #ACCOUNT_TYPES = { catalog_owner: 'catalog owner', free_account: 'free account', not_confirmed: 'not confirmed' } 
  SECRET_NAME = "opjeKDV79Ml4"
  
  mount_uploader :logo, LogoUploader
  after_commit :flush_cache
  
  
  
  include PgSearch
  pg_search_scope :search_account, against: [:title, :description, :contact_first_name, :contact_last_name, :contact_email, :fax], :using => [:tsearch]
  
  scope :activated,  ->  { where( activated: true).order("title asc")  }
  
  before_save :set_uuid
  
  def set_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  

  
  def has_no_name?
    title == Account::SECRET_NAME
  end
  
  def owner_has_no_name?
    account_owner.name == User::SECRET_NAME
  end
  
  def show_welcome_message?
    account_owner.show_welcome_message
  end
  
  def account_owner
    begin
      User.cached_find(user_id)
    rescue
      User.supers.first
    end
  end
  
  #def videos
  #  self.recordings.where(media_type: 'Video').order(:title)
  #end
  
  def assign_permissions
    
    
    #case account_type
    #  
    #when 'supervisor'
    #  SetPermissionsTo.supervisor administrators_account_user
    #when 'catalog owner'
    #  SetPermissionsTo.catalog_owner administrators_account_user
    #end
    
  end
  

  def administrator_email=(administrator_email)
    
    if user = User.where(email: administrator_email).first
      user.invite_existing_user_to_account @account
    else
      user = User.create( name: administrator_email, 
                          email: administrator_email, 
                          role: 'Administrator', 
                          password: 'rOUhPgxQYzWtMvIsby3kET5aKcLSmd0w', 
                          password_confirmation: 'rOUhPgxQYzWtMvIsby3kET5aKcLSmd0w',
                          current_account_id: self.id)
      user.new_account_and_user_confirmation( @account )
    end
    
    self.administrator_id = user.id
    self.save!
  end
  
  def administrator_email
    administrators_account_user.user.email
  end
  
  include Rails.application.routes.url_helpers
  
  def link
    case account_type.to_s
    when 'supervisor'
      supervisor_account_home_index_path(self)
    else
      account_path(self)
    end
  end
  
  #def self.administrator user_id
  #  AccountUser.where(user_id: self.administrator_id, account_id: self.id ).first
  #end
  
  #def account_administrator
  #  begin
  #    return User.cached_find(administrator_id)
  #  rescue
  #    administrator_id = User.supers.first
  #    save!
  #    return  User.cached_find(administrator_id)
  #  end
  #end
  
  def administrators_account_user

    unless account_user = AccountUser.cached_find(user_id: self.administrator_id, account_id: self.id )
      account_user = AccountUser.create(user_id: self.administrator_id, account_id: self.id ) if account_administrator
    end
    return account_user 
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def has_a_name
    begin
      User.cached_find(user_id).name == User.cached_find(user_id).email
    rescue
      user_id = User.supers.first
      name  << ' user deleted'
      save!
    end
    return false
  end
  
  # obsolete use uuid instead
  def raise_cache_version
    puts 'account.rb line 231 obsolete use uuid instead'
    #self.rec_cache_version += 1  
    #self.save
  end

  def self.search( query)
    if query.present?
      return Account.search_account(query)
    else
      return all
    end
  end
  
  
  
  def repair_users
    
    # secure there is a account_user for the account_owner
    account_owner = AccountUser.where(account_id: self.id, user_id: self.user_id)
                               .first_or_create(account_id: self.id, user_id: self.user_id, role: 'Account Owner')  
    
    # grand all permissions to the account owner
    account_owner.grand_all_permissions
    
    # 
    #self.account_users.each do |account_user|
    #  if( self.user_id == account_user.user_id)
    #    account_user.role = 'Account Owner'
    #  else
    #    account_user.role = 'Administrator'
    #    #AccountPermissions.update_user account_user, self
    #  end
    #  account_user.save!
    #end
  end
  
  def repair_recordings
    RecordingPermissions.repair_account_permissions self
  end
  
  def repair_works
    self.common_works.each do |work|
      work.update_completeness
    end
  end
  
  def repair_catalogs
    
  end
  
  def get_users_and_supers
    users_and_supers = self.users + User.supers
    users_and_supers.uniq!
    users_and_supers
  end
  
  #def get_account_users 
  #  #user_ids = []
  #  #user_ids += AccountUser.where(account_id: self.id).pluck(:user_id)
  #  #user_ids += User.where(role: 'super').pluck(:id)
  #  #user_ids <<  AccountUser.where(account_id: self.user_id).pluck(:user_id)
  #  users self.account_users + User.supers
  #  #user_ids.uniq!
  #  #AccountUser.where(user_id: user_ids, account_id: self.id)
  # end

  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Admin.cached_find(1).raise_accounts_version
  end

  #def init_activity_log
  #  ActivityLog.create!(account_id: id) unless ActivityLog.exists?(account_id: id)
  #end
  
  #def delete_user
  #  if User.exists?(user_id)
  #    user.destroy
  #  end
  #  #account_users = AccountUser.where(account_id: id)
  #  #account_users.delete_all
  #end
  
end
