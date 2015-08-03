class MusicSubmission < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to          :recording
  belongs_to          :music_request
  belongs_to          :user
  belongs_to          :account
  belongs_to          :opportunity_user
  has_many            :comments, as: :commentable
  after_commit        :flush_cache
  
  validates :recording_id, :music_request_id, :user_id, :account_id, presence: true
  has_many :music_submission_selections
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
