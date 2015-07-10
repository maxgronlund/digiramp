class DigitalSignature < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :image
  
  mount_uploader :image, SignatureUploader
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
end
