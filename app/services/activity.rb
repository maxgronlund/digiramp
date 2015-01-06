class Activity

  def initialize
  end
  
  def self.notify_followers notification, user_id, postable_type, postable_id
    
    unless FollowerEvent.where( user_id: user_id, 
                            postable_type: postable_type, 
                            postable_id: postable_id, 
                            created_at: (Time.now - 600)..Time.now).first

      #unless FollowerEvent.where(user_id: user_id, postable_type: postable_type, created_at: (Time.now - 300)..Time.now).count > 0
      send_notification( notification, user_id, postable_type, postable_id )
    end
    
    
    #if follower_event = FollowerEvent.where(user_id: user_id, postable_type: 'Recording', postable_id: postable_id).last
    #  # dont save the same messages to many times
    #  #if follower_event.created_at + 10.minutes  < Time.now
    #    send_notification( notification, user_id, postable_type, postable_id )
    #    #end
    #else 
    #  send_notification( notification, user_id, postable_type, postable_id )
    #end
    
  end
  
  def self.send_notification  notification, user_id, postable_type, postable_id
    
    FollowerEvent.create(  user_id:               user_id,
                           body:                  notification,
                           postable_type:         postable_type,
                           postable_id:           postable_id  
                          )
    
  end
  
 
end



#Activity.notify_followers( notification, user_id, postable_type, postable_id )