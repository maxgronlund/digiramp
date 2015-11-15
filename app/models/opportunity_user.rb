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
  
  before_destroy :set_user_recordings_before_destroy
  after_create :set_user_recordings_after_create
  
  def set_user_recordings_before_destroy
    unless self.user.destroyed? user.update_columns( 
        provide_to_opportunity: user.opportunity_users.where(provider: true).count > 1 ,
        review_opportunity:     user.opportunity_users.where(reviewer: true).count > 1 
      )
    end
  end
  
  def set_user_recordings_after_create
    unless self.user.destroyed?  user.update_columns( 
        provide_to_opportunity: user.opportunity_users.where(provider: true).count > 0 ,
        review_opportunity:     user.opportunity_users.where(reviewer: true).count > 0
      )
    end
  end
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.find_by_uuid(uuid)
    Rails.cache.fetch([name, uuid]) { find_by(uuid: uuid) }
  end
  
  def full_name
    return self.user.full_name if self.user

  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, uuid])
  end
end
