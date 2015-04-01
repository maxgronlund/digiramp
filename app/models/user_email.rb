class UserEmail < ActiveRecord::Base
  belongs_to :user
  validates_with UserEmailValidator 
  validates_formatting_of :email, :using => :email 
end
