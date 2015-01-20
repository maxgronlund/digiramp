class Campaign < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  has_and_belongs_to_many :client_groups
  has_many :campaign_events, dependent: :destroy
  

  
  STATUS = ['Draft', 'Delivered']
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
