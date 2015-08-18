class PublishingAgreement < ActiveRecord::Base
  has_paper_trail
  belongs_to :publisher
  #has_one :document
  
  has_many :ipi_publishing_agreements
  has_many :ipis, through: :ipi_publishing_agreements
  
  validates :email , presence: true
  validates_formatting_of :email, :using => :email
  
  #belongs_to :account, :through => :publisher
  #has_one :document
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def document
    Document.find_by(id: self.document_id)
  end
  
  def between
    if doc = document
      
    end
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
