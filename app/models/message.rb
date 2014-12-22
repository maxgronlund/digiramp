class Message < ActiveRecord::Base
  
  validates_presence_of :title
  
  after_commit :flush_cache
  belongs_to :connection
  
  
  before_create :attach_to_connection
  #before_destroy :update_connection
  
  def attach_to_connection
    Connection.attach_message self
  end
  
  #def update_connection
  #  Connection.update_messages_count self
  #end
  
  
  def sender
    begin
      User.cached_find(self.sender_id)
    rescue
      nil
    end
  end
  
  def receiver
    begin
      User.cached_find(self.recipient_id)
    rescue
      nil
    end
  end
  
  def self.user_messages user
    Message.order(created_at: :desc).where("recipient_id = ? AND recipient_removed = ? 
                                            OR sender_id = ? AND sender_removed = ?" , 
                                            user.id, false,  user.id, false
                                            )
    
  end
  
  def user_can_reply user 
    
    if Connection.exists?( self.connection_id)
      return connection.is_active
    end
    false
  end
  

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
      
end





