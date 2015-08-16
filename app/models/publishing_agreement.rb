class PublishingAgreement < ActiveRecord::Base
  has_paper_trail
  belongs_to :publisher
  #belongs_to :account, :through => :publisher
  #has_one :document
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
