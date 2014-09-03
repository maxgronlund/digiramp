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
  
  
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
