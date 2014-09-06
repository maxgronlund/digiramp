class Widget < ActiveRecord::Base
  
   
  belongs_to :catalog
  belongs_to :playlist
  belongs_to :account
  belongs_to :user
  
  
  mount_uploader :image, WidgetUploader
  after_commit :flush_cache
  
  def self.popular
    self.order('playback_count desc').last(10)
  end
  
  def self.cached_find(id)
    return Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def widget_theme
    begin
      WidgetTheme.cached_find(self.widget_theme_id)
    rescue
      WidgetTheme.first # !!! default here
    end
  end
  
  def recordings
    self.playlist.recordings if self.playlist
  end
  
  def add_recordings new_recordings
    playlist.add_recordings new_recordings
  end
  
  def add_recording new_recording
    playlist.add_recording new_recording
  end
  
  
  # !!! cache this
  def playlist
    ##################################### ALL PLAYLIST AND SHOULD HAVE A WIDGET 
    return self.playlist if self.playlist
    
    plaulest = Playlist.create(uuid: self.default_widget_key, 
                                user_id: self.account.user_id,
                                account_id: self.account_id,
                                title: self.title,
                                body: self.body
                             )
  end
  
  
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
