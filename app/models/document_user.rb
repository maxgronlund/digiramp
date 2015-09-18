class DocumentUser < ActiveRecord::Base
  has_paper_trail 
  belongs_to :document, primary_key: :uuid
  belongs_to :user
  belongs_to :account
  belongs_to :digital_signature
  
  validates :email, presence: true
  validates_formatting_of :email, :using => :email
  
  enum status: [ :pending, :accepted, :dismissed ]
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  
end
