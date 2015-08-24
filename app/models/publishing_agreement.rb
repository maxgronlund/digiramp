class PublishingAgreement < ActiveRecord::Base
  has_paper_trail
  belongs_to :publisher

  has_many :ipi_publishing_agreements
  has_many :ipis, through: :ipi_publishing_agreements
  
  #validates :email , presence: true
  #validates_formatting_of :email, :using => :email
  
  #belongs_to :account, :through => :publisher
  #has_one :document
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def document
    if document = Document.find_by(uuid: self.document_id)
      return document
    else
      document = Document.create( title: 'Publishing agreement',
                                  body: 'Publishing agreement',
                                  text_content: 'Publishing agreement',
                                  account_id: self.publisher.account_id,
                                  document_type: 'Legal',
                                  uuid: UUIDTools::UUID.timestamp_create().to_s
                                 )
      self.update(document_id: document.uuid)
    end
    document
  end
  
  def between
    if doc = document
      
    end
  end
  
  def expires
    document.expires
  end
  
  def expiration_date
    document.expiration_date
  end
  
  def deletable
    true
  end
  
  
  def act_as_deleted
    
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
