# connections can be deleted without deleting messages

class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :connection, :class_name => 'User'
  has_many :messages
  
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
    return created_by_me( requester ) ? connected_to : user
  end
  
  def created_by_me requester
    self.user_id == requester.id
  end
  
  # It's possible to send messages to users that are not connected
  def self.attach_message message
    if connection = message_connection( message )
      
      message.connection_id = connection.id
      connection.messages_count += 1 
      connection.save!                  
    end
  end
  
  def self.decrease_messages_count message

    if connection = message_connection( message )
      connection.messages_count -= 1 
      connection.save!                  
    end
  end
  
  def self.message_connection message
    
    connection = where("user_id = ? AND connection_id = ? 
                        OR user_id = ? AND connection_id = ?" , 
                        message.sender_id, message.recipient_id, 
                        message.recipient_id, message.sender_id).first
    
  end
  
  def status
    return 'Connected'   if self.is_active
    return 'Pending'    if self.is_pending
    return 'Declined'  if self.is_dismissed
    ''
  end
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  
  def connected_to
    User.find(self.connection_id) if User.exists?(self.connection_id)
  end

end
