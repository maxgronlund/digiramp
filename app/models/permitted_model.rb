class PermittedModel < ActiveRecord::Base
  belongs_to :user ##!!! This needs to be removed
  belongs_to :account_user
  belongs_to :permitted_model_type
  #has_many :permitted_model_actions, dependent: :destroy
  #has_many :permissions, as: :permissionable # permissions is the link between the permitted model and the user
end
