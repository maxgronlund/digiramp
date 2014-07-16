class Opportunity < ActiveRecord::Base
  
  has_many :music_requests, dependent: :destroy
  belongs_to :account
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def submission_count
    return submissions.size if submissions
    0
  end
  
  def submissions
    MusicSubmission.where( music_request_id: music_request_ids)
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end

