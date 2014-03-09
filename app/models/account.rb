class Account < ActiveRecord::Base
  
  belongs_to :user
  
  after_create :init_activity_log
  #after_create :assign_permissions
  #after_create :validate_expiration_date
  
  has_one :activity_log
  has_many :account_catalogs, dependent: :destroy
  has_many :activity_events, as: :activity_eventable
  
  has_many :invites
  has_many :playlists
  has_many :songs
  
  has_many :common_works_imports
  has_many :common_works
  has_many :import_ipis
  has_many :notifications
  
  has_many :recordings
  has_many :representatives, dependent: :destroy
  has_many :albums
  has_many :documents, dependent: :destroy
  has_many :music_opportunities
  
  
  #belongs_to :user
  #accepts_nested_attributes_for :user
  has_many :account_users, dependent: :destroy
  has_many :users, :through => :account_users
  
  has_many :music_oppertunity_submitions
  

  
  #has_many :recording_imports, dependent: :destroy
  #has_many :documents, as: :documentable, dependent: :destroy
  validates_presence_of :title
  
  ACCOUNT_TYPES = [ 'catalog owner', 'representative', 'supervisor', 'administrator', 'free account']
  
  mount_uploader :logo, LogoUploader
  
  def videos
    self.recordings.where(media_type: 'Video').order(:title)
  end
  
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
  
  def account_administrator
    
    User.cached_find(self.administrator_id)
  end
  
  def administrators_account_user

    unless account_user = AccountUser.where(user_id: self.administrator_id, account_id: self.id ).first
      account_user = AccountUser.create(user_id: self.administrator_id, account_id: self.id ) if account_administrator
    end
    return account_user 
  end
  
  
    
  
private

  def init_activity_log
    ActivityLog.create!(account_id: id) unless ActivityLog.exists?(account_id: id)
  end
  
  
end
