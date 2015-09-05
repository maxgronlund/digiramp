class UserConfiguration < ActiveRecord::Base
  belongs_to :user
  
  enum status: [ :pending, :activated, :deactivated, :expired, :done ]
  
  def show?
    
    #return false if self.dont_ask_me_again
    
    return true if self.pending?
    return true if self.activated?
    return false if self.deactivated?
    return false if self.done?
    true
    
  end
  
  # show todo if it's a long time ago
  def time_to_show
    
  end
  
  #user.next_up?
  def next_up?
    #self.update(configured: false)
    #return 'done' if self.configured
    
    if self.i_want_to_promote_my_music
      unless self.upload_recordings_later           
        return 'upload_recordings'    if user.recordings.count          == 0 
      end
      unless self.create_a_playlist_later           
        return 'create_a_playlist'    if user.playlists.count           == 0 
      end
      unless self.invite_friends_later              
        return 'invite_friends'       if user.client_invitations.count  == 0 
      end
      unless self.post_on_facebook_later            
        return 'post_on_facebook'     if user.share_on_facebooks.count  == 0 
      end
      unless self.post_on_twitter_later             
        return 'post_on_twitter'      if user.share_on_twitters.count   == 0 
      end
    end
    
    if self.i_want_to_sell_music
      return 'register_a_publisher'         if      user.user_publishers.count           == 0
      return 'upload_recordings'            if      user.recordings.count                == 0
      return 'clear a recording'            if      user.has_no_cleared_recording?
      return 'enable shop'                  unless  user.has_enabled_shop
      return 'add a recording to the shop'  if      user.products.on_sale.count          == 0
    end
    
    if self.i_want_to_get_my_music_into_films_and_tv
      return 'upload_recordings'            if user.recordings.count                == 0
      return 'register a publisher'         if user.user_publishers.count           == 0
      return 'submit to an opportunity'     if user.opportunity_users.count     == 0
    end
    
    if self.i_want_to_find_and_listen_to_music
      return 'like a recording'              if user.likes.count                    == 0
      return 'create_a_playlist'             if user.playlists.count                == 0 && !user.create_a_playlist_later
      return 'add a recording to a playlist' if user.has_no_recordings_on_playlist?
      return 'post on facebook'              if user.share_on_facebooks.count       == 0
      return 'post on twitter'               if user.share_on_twitters.count        == 0
    end
    
    if self.i_want_to_sell_goods
      
    end
    
    if self.i_want_to_offer_services
      
    end
    
    if self.i_want_to_collaborate
      
    end
    
    if self.i_want_to_manage_users_and_catalogs
      
    end
    
    if self.i_want_to_build_custom_web_pages
      
    end
    
    if self.dont_ask_me_again
      
    end
    
    self.done!

    
  end
  
  def reset!
    
    self.update(
                upload_recordings_later:            user.recordings.count  != 0 ,
                create_a_playlist_later:            user.playlists.count   != 0,
                invite_friends_later:               false,
                post_on_facebook_later:             false,
                post_on_twitter_later:              false,
                register_a_publisher_later:         false,
                clear_a_recording_later:            false,
                enable_shop_later:                  false,
                add_a_recording_to_the_shop_later:  false
              )
    self.activated!
  end
  
  after_commit :flush_cache
 

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  

  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
  
  
  
  
  
  
end
