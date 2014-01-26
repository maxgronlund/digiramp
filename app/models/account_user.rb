class AccountUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  after_create :init_permissions
  has_many :permitted_models, dependent: :destroy
  accepts_nested_attributes_for :permitted_models
  
  #has_many :permissions
  #has_many :permitted_models, dependent: :destroy #!!! moving to account_user
  
  validates_uniqueness_of :user_id, :scope => :account_id
  #attr_accessible :role, :user_id, :account_id
  
  ## Usage:
  ## account_user.has_permission_for_model? "r", "Recording", account_id
  
  ROLES = ["Administrator", "Accountant", "Artist", "Guest", "Representative", "Supervisor", "Content provider"]

  #def admin_or_super?;  admin? || super?              end
  #def super?;           role == 'super'               end
  #def account_owner?;   role == 'account owner'       end
  #def admin?;           role == 'admin'               end
  #def representative?;  role == 'representative'      end
  #def guest?;           role == 'guest' || role.nil?  end # Until role is set to :guest by default
  #def supervisor?;      role == 'supervisor'          end
  #
  def email
    
  end
  
  def has_permission_for? action, permitted_model_id
    if permitted_model = permitted_models.where( permitted_model_type_id: permitted_model_id).first
      return permitted_model.public_send(action)
    else
      return false
    end
  end  
  
  def build_permissions
    PermittedModelType.order("ui_name asc").each do |permitted_model_type|
      pm = permitted_models.create(permitted_model_type_id: permitted_model_type.id,
                              account_user_id: self.id,
                              user_id: self.user_id,
                              c:  permitted_model_type.c,
                              r:  permitted_model_type.r,
                              u:  permitted_model_type.u,
                              d:  permitted_model_type.d)
    end
  end
  
  def init_permissions
    PermittedModelType.all.each do |permitted_model_type|
      permitted_model_type.add_to_account_user self
    end
    #def add_to_account_user(account_user)
    #  account_user.permitted_models.where(permitted_model_type_id: id).first_or_create
    #end
  end
  
  def get_role_for user
    if account.administrator_id == user.id
      return 'Administrator'
    else
      return self.role
    end
  end
end
