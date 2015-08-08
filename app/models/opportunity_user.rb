class OpportunityUser < ActiveRecord::Base
  include PublicActivity::Common
  
  belongs_to    :user
  belongs_to    :opportunity
  has_many      :music_submissions, dependent: :destroy
  has_many      :music_submission_selections
  has_many      :comments,        as: :commentable,          dependent: :destroy
  after_commit  :flush_cache
  #before_destroy :destroy_music_submissions
  
  #def destroy_music_submissions
  #  self.music_submissions.destroy_all
  #end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.find_by_uuid(uuid)
    Rails.cache.fetch([name, uuid]) { find_by(uuid: uuid) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, uuid])
  end
end
