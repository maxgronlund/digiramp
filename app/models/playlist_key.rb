class PlaylistKey < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user
  
  has_many :customer_events
  validates_confirmation_of :password
  validates_presence_of :password, :on => :update, if: :secure_access?
  
  
  after_commit :flush_cache
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def has_public_access?
    !secure_access
  end 
  
  def secure_access?
    secure_access
  end
  
private                  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
