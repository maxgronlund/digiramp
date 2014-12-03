# A playlist is an aggreation of playlist items


class Playlist < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  #has_many :playlist_items, dependent: :destroy
  has_many :playlist_keys,  dependent: :destroy
  has_many :widgets
  has_and_belongs_to_many :recordings, dependent: :destroy
  has_many :comments,        as: :commentable,          dependent: :destroy

  
  after_commit :flush_cache
  #before_save :update_uuids
  #before_destroy :update_uuids
  after_create :create_default_objects
  
  #mount_uploader :image, PlaylistUploader
  mount_uploader :playlist_image, PlaylistUploader

  
  def create_default_objects
    create_default_widget
    create_default_key
  end
  
  def create_default_widget
    default_widget = Widget.create(
                              title:            self.title,
                              body:             self.body,
                              secret_key:       UUIDTools::UUID.timestamp_create().to_s,
                              widget_theme_id:  WidgetTheme.default.id,
                              user_id:          self.user_id,
                              account_id:       self.account_id,
                              #catalog_id:       self.id,
                              playlist_id:      self.id
                            )
    self.default_widget_id = default_widget.id
    self.save
  end

  def create_default_key 

    PlaylistKey.create(
                             default: true,
                         playlist_id: self.id,
                             user_id: self.user_id,
                          account_id: self.account_id,
                       secure_access: true,
                            password: UUIDTools::UUID.timestamp_create().to_s,
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
  
  # make a PlaylistKey 
  def playlist_key
    PlaylistKey.where(playlist_id:  self.id
               .first_or_create( playlist_id: self.id,
                                 user_id:     self.account.user_id,
                                 account_id:  self.account_id),
                                 secure_access: true,
                                 password: UUIDTools::UUID.timestamp_create().to_s,
                                 expires: false,
                                 expiration_date: Date.current() >> 1,
                                 page_link: 'http://digiramp.com',
                                 status: 'new'
                               )
    

  end
  
  #def recordings
  #  recording_ids = self.playlist_items.where(playlist_itemable_type: 'Recording').pluck(:playlist_itemable_id)
  #  Recording.where(id: recording_ids)
  #end
  
  def add_item new_item
    self.playlist_items.where(playlist_id:            self.id,
                              playlist_itemable_type: new_item.class.name, 
                              playlist_itemable_id:   new_item.id)
                       .first_or_create( playlist_id:            self.id,
                                         playlist_itemable_type: new_item.class.name,
                                         playlist_itemable_id:   new_item.id)
  end
  
  def add_items new_items
    new_items.each do |item|
      add_item item
    end
  end
  
  def remove_item item

    if item = PlaylistItem.where(  playlist_id:           self.id, 
                                   playlist_itemable_id:  item.id,
                                  playlist_itemable_type: item.class.name
                                )
                                            
      item.destroy 
      return true                                 
    end
    false
  end
  
  def default_widget
    Widget.cached_find(self.default_widget_id)
  end

  
  def preview
    playlist_keys.where(default: true).first.playlist_url
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end 
  
private     
             
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  
end
