class DocumentUser < ActiveRecord::Base
  belongs_to :document, primary_key: :uuid
  belongs_to :user
  belongs_to :account
  
  validates :email, presence: true
  validates_formatting_of :email, :using => :email
  
  enum status: [ :pending, :viewed, :signed, :archived ]
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  
end
