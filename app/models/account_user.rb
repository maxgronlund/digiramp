class AccountUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :customer_events
  
  #after_create :init_permissions
  #has_many :permitted_models, dependent: :destroy
  #accepts_nested_attributes_for :permitted_models
  
  #has_many :permissions
  #has_many :permitted_models, dependent: :destroy #!!! moving to account_user
  
  validates_uniqueness_of :user_id, :scope => :account_id
  #attr_accessible :role, :user_id, :account_id
  
  ## Usage:
  ## account_user.has_permission_for_model? "r", "Recording", account_id
  
  ROLES = ["Account Owner", "Administrator", "Client", "Associate"]
  
  include PgSearch
  pg_search_scope :search_account_user, against: [:name, :email, :note, :phone], :using => [:tsearch]
  
  after_commit :flush_cache

  #def admin_or_super?;  admin? || super?              end
  #def super?;           role == 'super'               end
  #def account_owner?;   role == 'account owner'       end
  #def admin?;           role == 'admin'               end
  #def representative?;  role == 'representative'      end
  #def guest?;           role == 'guest' || role.nil?  end # Until role is set to :guest by default
  #def supervisor?;      role == 'supervisor'          end
  #
  
  scope :editors,  ->  { where.not( role: 'Client').order("name asc")  }
  scope :clients,  ->  { where( role: 'Client').order("name asc")  }
  


  
  def mount_user
    if user_id == -1
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      
      new_user = User.where(account_id: account_id, email: email)
                     .first_or_create(account_id: account_id, 
                                       name: get_name, 
                                       email: email, 
                                       role: 'cuctomer',
                                       password: secret_temp_password,
                                       password_confirmation: secret_temp_password, 
                                       activated: false)
      self.user_id = new_user.id
      self.save!
    end
  end
  
  
  
  def get_email
    return email unless email == ''
    return user.email
  end
  
  def associate?
    role == 'Associate'
  end
  
  def client?
    role == 'Client'
  end
  
  def administrator?
    role == 'Administrator'
  end
  
  def owner?
    role == 'Account Owner'
  end
  
  def can_administrate?
    administrator? || owner?
  end
  
  def get_name
    return name       unless name.to_s == ''
    if user
      return user.name  unless user.name.to_s == ''
      return user.email
    end
    return email
  end
  
  def get_phone
    phone
  end
  
  def can_access_assets?
    access_to_all_recordings || access_to_all_common_works
  end
  
  def can_collect?
    access_to_collect || administrator?
  end
  
  def has_access_to_all_documents? 
    access_to_all_documents || administrator?
  end
  
  def has_access_to_all_rights?
    access_to_all_rights || administrator?
  end
  
  def has_access_to_all_common_works?
    access_to_all_common_works || administrator?
  end
  
  

  def self.account_search(account, query)
    account_users = account.account_users
    if query.present?
      return account_users.search_account_user(query)
    else
      return account_users
    end
  end
  

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_where(account_id, user_id)
    Rails.cache.fetch([ 'account_user', account_id, user_id]) { where( account_id: account_id, user_id: user_id ).first }
  end
  



private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['account_user', account_id, user_id])
  end
  
  #def has_permission_for? action, permitted_model_id
  #  if permitted_model = permitted_models.where( permitted_model_type_id: permitted_model_id).first
  #    return permitted_model.public_send(action)
  #  else
  #    return false
  #  end
  #end  
  #
  #def build_permissions
  #  PermittedModelType.order("ui_name asc").each do |permitted_model_type|
  #    pm = permitted_models.create(permitted_model_type_id: permitted_model_type.id,
  #                            account_user_id: self.id,
  #                            user_id: self.user_id,
  #                            c:  permitted_model_type.c,
  #                            r:  permitted_model_type.r,
  #                            u:  permitted_model_type.u,
  #                            d:  permitted_model_type.d)
  #  end
  #end
  #
  #def init_permissions
  #  PermittedModelType.all.each do |permitted_model_type|
  #    permitted_model_type.add_to_account_user self
  #  end
  #  #def add_to_account_user(account_user)
  #  #  account_user.permitted_models.where(permitted_model_type_id: id).first_or_create
  #  #end
  #end
  
  #def get_role_for user
  #  if account.administrator_id == user.id
  #    return 'Administrator'
  #  else
  #    return self.role
  #  end
  #end
end
