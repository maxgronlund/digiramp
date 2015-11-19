class UserConfiguration < ActiveRecord::Base
  belongs_to :user
  
  enum status: [ :pending, :activated, :deactivated, :expired, :done ]
  
  def show?
    
    #return false if self.dont_ask_me_again
    
    return true  if self.pending?
    return true  if self.activated?
    return false if self.deactivated?
    return false if self.done?
    
    
  end
  
  # show todo if it's a long time ago
  def time_to_show
    
  end
  
  #user.next_up?
  def next_up?
    
    #self.update(configured: false)
    #return 'done' if self.configured
    return 'done' if self.done?
    
    
    # promote music
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
    
    
    
    # sell music
    if self.i_want_to_sell_music

      unless add_legal_informations_later
        return 'add_legal_informations' unless user.legal_informations_completed?
      end
      
      unless add_digital_signature_later
        return 'add_digital_signature' unless !user.digital_signature_uuid.nil?
      end
      
      #unless register_a_publisher_later
      #  return 'register_a_publisher'  if user.user_publishers.count  == 0
      #end
      
      
      unless self.upload_recordings_later           
        return 'upload_recordings'    if user.recordings.count          == 0 
      end
      
      unless self.clear_a_recording_later
        if user.recordings.count  > 0 
          return 'clear_a_recording'    if user.has_no_cleared_recording?
        end
      end
      
      unless enable_shop_later
        return 'enable_shop'                  unless  user.has_enabled_shop
      end
      
      #unless add_a_recording_to_the_shop_later
      #  if user.has_enabled_shop
      #    return 'add_a_recording_to_the_shop'  if user.products.on_sale.where(category: 'recording').count == 0
      #  end
      #end
      
    end
    
    
    # sell goods
    if self.i_want_to_sell_goods
      
      unless add_legal_informations_later
        return 'add_legal_informations' unless user.legal_informations_completed?
      end
      
      unless add_digital_signature_later
        return 'add_digital_signature' unless !user.digital_signature_uuid.nil?
      end
      
      unless enable_shop_later
        return 'enable_shop'                  unless  user.has_enabled_shop
      end
      
      unless add_physical_product_later
        if user.has_enabled_shop
          return 'add_physical_product'         if  user.products.on_sale.where(category: 'physical-product').count == 0
        end
      end 
    end
    
    
    # License music
    if self.i_want_to_get_my_music_into_films_and_tv
      
      unless add_legal_informations_later
        return 'add_legal_informations' unless user.legal_informations_completed?
      end
      
      unless add_digital_signature_later
        return 'add_digital_signature' unless !user.digital_signature_uuid.nil?
      end
      
      #unless self.register_a_publisher_later 
      #  return 'register_a_publisher'         if user.user_publishers.count  == 0
      #end
      
      unless self.upload_recordings_later           
        return 'upload_recordings'    if user.recordings.count  == 0 
      end
      
      unless self.clear_a_recording_later
        return 'clear_a_recording'    if user.first_uncleared_recording
      end
      
      unless self.submit_to_an_opportunity_later
        if user.recordings.count  > 0 
          unless user.has_no_cleared_recording?
            return 'submit_to_an_opportunity'  if user.opportunity_users.count   == 0
          end
        end
      end
    end
    
    
    
    
    if self.i_want_to_find_and_listen_to_music
      unless self.like_a_recording_later
        return 'like_a_recording'
      end              
      
      unless self.create_a_playlist_later           
        return 'create_a_playlist'    if user.playlists.count           == 0 
      end
      
      unless self.add_recording_to_a_playlist_later
        return 'add_recording_to_a_playlist' if self.user.has_no_recordings_on_playlist?
      end
      
      return 'add a recording to a playlist' if user.has_no_recordings_on_playlist?
      return 'post on facebook'              if user.share_on_facebooks.count       == 0
      return 'post on twitter'               if user.share_on_twitters.count        == 0
    end
    
    
    
    
    
    
    if self.i_want_to_offer_services
      unless add_legal_informations_later
        return 'add_legal_informations' unless user.legal_informations_completed?
      end
      
      unless add_digital_signature_later
        return 'add_digital_signature' unless !user.digital_signature_uuid.nil?
      end
      
      unless enable_shop_later
        return 'enable_shop'                  unless  user.has_enabled_shop
      end
      
    end
    
    if self.i_want_to_collaborate
      
    end
    
    if self.i_want_to_manage_users_and_catalogs
      unless add_legal_informations_later
        return 'add_legal_informations' unless user.legal_informations_completed?
      end
      
    end
    
    if self.i_want_to_build_custom_web_pages
      
    end
    
    if self.dont_ask_me_again
      
    end
    
    self.done! unless( self.pending?)

    
  end
  
  def reset!
    self.update(
                upload_recordings_later:            user.recordings.count         != 0 ,
                create_a_playlist_later:            user.playlists.count          != 0,
                invite_friends_later:               user.client_invitations.count != 0,
                post_on_facebook_later:             user.share_on_facebooks.count != 0,
                post_on_twitter_later:              user.share_on_twitters.count  != 0,
                #register_a_publisher_later:         user.user_publishers.count    != 0,
                clear_a_recording_later:            !user.has_no_cleared_recording?,
                enable_shop_later:                  user.has_enabled_shop,
                like_a_recording_later:             user.likes != 0,
                add_a_recording_to_the_shop_later:  user.products.on_sale.where(category: 'recording').count > 0,
                add_physical_product_later:         user.products.on_sale.where(category: 'physical-product').count > 0,
                add_recording_to_a_playlist_later:  !user.has_no_recordings_on_playlist?,
                add_digital_signature_later:        !user.digital_signature_uuid.nil?
              )
    self.activated!
  end
  
  
 

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  # used to remind users to update their configuration
  before_save :set_configured
  def set_configured
    return if configured
    configured        = i_want_to_promote_my_music
    configured        = i_want_to_sell_music                        ||  configured
    configured        = i_want_to_get_my_music_into_films_and_tv    ||  configured
    configured        = i_want_to_find_and_listen_to_music          ||  configured
    configured        = i_want_to_sell_goods                        ||  configured
    configured        = i_want_to_offer_services                    ||  configured
    configured        = i_want_to_collaborate                       ||  configured
    configured        = i_want_to_manage_users_and_catalogs         ||  configured
    configured        = i_want_to_build_custom_web_pages            ||  configured
    configured        = true if self.status == 'done'
    
    if configured
      self.update_columns( configured: true)                                 
      self.user.update(  user_configuration_configured: configured)
    end

  end
  

  private 

  after_commit :flush_cache
  def flush_cache
    
    Rails.cache.delete([self.class.name, id])
  end
  
  
  
  
  
  
  
  
end
