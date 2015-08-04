class RecordingUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  #validates :email, uniqueness: true, presence: true
  validates_formatting_of :email, :using => :email
  after_create :attach_user
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def attach_user
    if user = User.find_by(email: self.email)
      self.update(user_id: user.id)
    end
  end
end
