class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :connection, :class_name => 'User'
  
  def is_active
    self.approved == true && self.dismissed == false
  end
  
  def is_pending
    self.approved == false && self.dismissed == false
  end
  
  def is_dismissed
    self.dismissed == true
  end
  
  
  def self.connected user_a, user_b
    where("user_id = ? AND connection_id = ? OR user_id = ? AND connection_id = ?" , user_a, user_b, user_b, user_a).first
  end
  
  def connected_to_user requester
    return user.id == requester.id ? connected_to : user
  end
  
  private
  
  def connected_to
    User.find(self.connection_id) if User.exists?(self.connection_id)
  end

end
