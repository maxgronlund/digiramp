class Catalog< ActiveRecord::Base
  
  belongs_to :account
  has_many :catalog_items, dependent: :destroy
  has_many :catalog_users, dependent: :destroy
  #belongs_to :catalog_itemable, polymorphic: true
  #attr_accessible :catalog_itemable_type, :catalog_itemable_id, :account_catalog_id
  
  after_commit :flush_cache
  

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def nr_recordings
    catalog_items.where(catalog_itemable_type: 'Recording').size
  end
  
  def recordings
    recording_ids = catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    Recording.where(id: recording_ids)
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
