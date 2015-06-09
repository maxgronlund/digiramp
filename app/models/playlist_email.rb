class PlaylistEmail < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user
  belongs_to :account
  

  validates :title, :body, :email_list, presence: true
  validates_with EmailListValidator, fields: [:email_list]
  
  after_create :send_playlist
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  def send_playlist
    
    PlaylistEmailMailer.delay.send_email( self.id )

  end
end
