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

end
