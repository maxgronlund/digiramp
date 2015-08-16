# the glue that binds a user to a publisher
class UserPublisher < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :user
  
end
