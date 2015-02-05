class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :replyable, polymorphic: true
  mount_uploader :image, ArtworkUploader
  
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { where(id: id).first }
  end
  
  private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
