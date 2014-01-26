class Permission < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :permissionable, polymorphic: true
  
  validates_uniqueness_of :user_id, :scope => [:permissionable_type, :permissionable_id]
  
  has_many :permitted_actions, dependent: :destroy
  
  def granted_by_user;  User.find    granted_by_user_id end
  def granted_by_user?; User.exists? granted_by_user_id end
  
end