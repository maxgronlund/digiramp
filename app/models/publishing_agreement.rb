class PublishingAgreement < ActiveRecord::Base
  has_paper_trail
  belongs_to :publisher
  belongs_to :account

  has_many :ipi_publishing_agreements
  has_many :ipis, through: :ipi_publishing_agreements
  
  has_many :ipi_publishers
  has_many :ipis,   :through => :ipi_publishers 
  
  before_destroy :remove_relations
  
  validates :split, :title, presence: true
  validates :split, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  
  def remove_relations
    document.destroy if document
  end
  
  #validates :email , presence: true
  #validates_formatting_of :email, :using => :email
  
  #belongs_to :account, :through => :publisher
  #has_one :document
  after_commit :flush_cache
  
  
  def configure_payment( royalty, price, recording_uuid )

    begin
      
      amount_in_cent =  self.split * 0.01 * royalty
      amount_in_pct  =  amount_in_cent /  price
      
      #ap "amount_in_cent: #{amount_in_cent}"
      #ap "royalty; #{royalty}"
      #ap "split: #{split}"
      #
    
      if stake = Stake.find_by( 
          account_id:  self.account_id,
          asset_id:           recording_uuid,
          asset_type:         'Recording',
          ip_uuid:            self.uuid,
          ip_type:            self.class.name
        )
        stake.update(
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent.round,
          currency:            'usd',
          email:               self.publisher.email,
          unassigned:          false,
        )
      else
        stake = Stake.create(  
          account_id:          self.account_id,
          user_id:             self.user_id,
          asset_id:            recording_uuid,
          asset_type:          'Recording',
          ip_uuid:             self.uuid,
          ip_type:             self.class.name,
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent.round,
          currency:            'usd',
          email:               self.publisher.email,
          unassigned:          false
        )
      end
      #ap stake
      return royalty -  amount_in_cent
    rescue => e
      ErrorNotification.post_object 'PublishingAgreement#configure_payment', e
      return 0
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def documents
    Document.where(belongs_to_id: self.id, belongs_to_type: self.class.name)
  end
  
  def document
    Document.cached_find(self.document_uuid)
    #if document = Document.cached_find(self.document_id)
    #  document.update(document_type: 'Publishing agreement')
    #  return document
    #else
    #  document = Document.create( title: 'Publishing agreement',
    #                              body: 'Publishing agreement',
    #                              text_content: 'Publishing agreement',
    #                              account_id: self.publisher.account_id,
    #                              document_type: 'Publishing agreement',
    #                              uuid: UUIDTools::UUID.timestamp_create().to_s
    #                             )
    #  self.update(document_id: document.uuid)
    #  if self_publishing?
    #    document.executed!
    #  end
    #end
    #document
  end
  
  
  
  #def self_publishing?
  #  if self.publisher
  #   return self.publisher.i_am_my_own_publisher
  # end
  #end
  
  #def between
  #  if doc = document
  #    
  #  end
  #end
  
  #def expires
  #  document.expires
  #end
  #
  #def expiration_date
  #  document.expiration_date
  #end
  
  #def deletable
  #  true
  #end
  #
  #
  #def act_as_deleted
  #  
  #end
  

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
