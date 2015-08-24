class DigitalSignature < ActiveRecord::Base
  belongs_to :user
  #validates_presence_of :image
  belongs_to :signable, polymorphic: true

  mount_uploader :image, SignatureUploader
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.clone_signatures_from source, destination
    source.digital_signatures.to_a.each do |signature|
      
      DigitalSignature.create( uuid: UUIDTools::UUID.timestamp_create().to_s,
                               signable_id:   destination,
                               signable_type: destination.class.name,
                               role:         source.role
                              )

    end
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
end
