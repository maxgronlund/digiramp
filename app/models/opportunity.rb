class Opportunity < ActiveRecord::Base
  include PublicActivity::Common
  has_many        :opportunity_invitations
  has_many        :music_requests, dependent: :destroy
  has_many        :opportunity_users, dependent: :destroy
  belongs_to      :account
  after_commit    :flush_cache
  
  
  
  def submission_count
    return submissions.size if submissions
    0
  end
  
  def submissions
    MusicSubmission.where( music_request_id: music_request_ids)
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end

