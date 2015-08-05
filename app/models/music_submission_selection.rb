class MusicSubmissionSelection < ActiveRecord::Base
  belongs_to :account
  belongs_to :music_submission
  belongs_to :music_request
  belongs_to :user
  belongs_to :opportunity_user
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
