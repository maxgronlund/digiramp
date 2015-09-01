class UserConfiguration < ActiveRecord::Base
  belongs_to :user
  
  enum status: [ :pending, :activated, :deactivated, :expired ]
  
  def show?
    
    #return false if self.dont_ask_me_again
    
    return true if self.pending?
    return true if self.activated?
    return false if self.deactivated?
    
  end
  
  # show todo if it's a long time ago
  def time_to_show
    
  end
  
  #user.next_up?
  def next_up?
    self.update(configured: false)
    return 'done' if self.configured
    
    if self.i_want_to_promote_my_music
      return 'upload recordings'    if user.recordings.count                   == 0
      return 'create a playlist'    if user.playlists.count                    == 0
      return 'invite friends'       if user.client_invitations.count           == 0
      return 'post on facebook'     if user.share_on_facebooks.count           == 0
      return 'post on twitter'      if user.share_on_twitters.count            == 0
    end
    
    if self.i_want_to_sell_music
      return 'register_a_publisher' if user.user_publishers.count           == 0
      return 'upload recordings'    if user.recordings.count                == 0
      return 'clear a recording'    if user.has_no_cleared_recording?
      return 'enable shop'          if user.user_publishers.count           == 0
    end
    
    if self.i_want_to_get_my_music_into_films_and_tv
      return 'upload recordings'    if user.recordings.count                == 0
      return 'register_a_publisher' if user.user_publishers.count           == 0
      return 'submit to an opportunity' if user.opportunity_users.count     == 0
    end
    
    if self.i_want_to_find_and_listen_to_music
      return 'like a recording'              if user.likes.count                    == 0
      return 'create a playlist'             if user.playlists.count                == 0
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
    
    #self.update(configured: true)
    
      
    
    return 'done'
    
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
