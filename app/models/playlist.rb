class Playlist < ActiveRecord::Base
  belongs_to :account
  has_one :widget
  has_many :playlist_items, dependent: :destroy
  has_many :playlist_keys, dependent: :destroy
  #has_many :activity_events, as: :activity_eventable
  #has_many :invites,         as: :inviteable
  #has_many :permissions, as: :permissionable
  
  after_commit :flush_cache
  #before_save :update_uuids
  #before_destroy :update_uuids
  after_create :add_default_objects
  
  
  def add_default_objects
    add_default_playlist_key
    add_default_widget
  end
  
  def add_default_playlist_key
    
    secret_temp_password  = UUIDTools::UUID.timestamp_create().to_s
    playlist_key          = PlaylistKey.create(
                                                     default: true,
                                                 playlist_id: self.id,
                                                     user_id: self.account.user_id,
                                                  account_id: self.account_id,
                                               secure_access: true,
                                                    password: secret_temp_password,
                                                     expires: false,
                                             expiration_date: Date.current() >> 365,
                                                   page_link: '',
                                                      status: 'new',
                                                      enable: 'false',
                                                       title: 'Default Key',
                                                        body: '',
                                                playlist_url: UUIDTools::UUID.timestamp_create().to_s
                                               )
    
    
  end
  
  def add_default_widget
    self.default_widget_key = UUIDTools::UUID.timestamp_create().to_s
    self.save
    @widget     = Widget.create(
                                  title:            self.title,
                                  body:             self.body,
                                  secret_key:       self.default_widget_key,
                                  account_id:       self.account_id,
                                  user_id:          self.user_id,
                                  playlist_id:      self.id,
                                  catalog_id:       nil,
                                  widget_theme_id:  WidgetTheme.where(title: 'Default').first.id
                                )
    
   
  end
  
  def default_widget
    Widget.where(secret_key: self.default_widget_key).first
  end
  
  
  
  def self.create_playlist_with_key account, account_user
    
    # create a playlist
    playlist = Playlist.create( account_id: account.id,
                                title: "Playlist for #{account_user.get_name}"
                              )
    # make a PlaylistKey 
    secret_temp_password  = UUIDTools::UUID.timestamp_create().to_s
    playlist_key          = PlaylistKey.create(
                                                 playlist_id: playlist.id,
                                                 user_id: account_user.user_id,
                                                 account_id: account.id,
                                                 secure_access: true,
                                                 password: secret_temp_password,
                                                 expires: false,
                                                 expiration_date: Date.current() >> 1,
                                                 page_link: 'google.com',
                                                 status: 'new'
                                               )
    playlist_key.id
                                      
  end
  
  def recordings
    recording_ids = self.playlist_items.where(playlist_itemable_type: 'Recording').pluck(:playlist_itemable_id)
    Recording.find(recording_ids)
  end
  
  def perview
     
    begin
      return self.playlist_keys.first.playlist_url
    rescue
      return nil
    end
    #self.playlist_keys.where(default: true).first
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end 
  
private                  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def update_uuids
    AccountCache.update_playlists_uuid account
    self.uuid =  UUIDTools::UUID.timestamp_create().to_s
  end
  
  
end
