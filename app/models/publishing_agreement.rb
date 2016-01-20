class PublishingAgreement < ActiveRecord::Base
  has_paper_trail
  belongs_to :publisher
  belongs_to :user
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
  
  def create_stake( shop_product, recording, royalty )
    Notifyer.print( 'PublishingAgreement#create_stake' , {shop_product_id: shop_product.id, recording_uuid: recording.uuid, publishing_agreement: self} ) if Rails.env.development?
    
    begin
      royalty_in_cent =  self.split * 0.01 * royalty
      royalty_in_pct  =  royalty_in_cent /  shop_product.price
      
      
      stake = Stake.create(  
        account_id:          self.account_id,
        user_id:             self.user_id,
        asset_id:            recording.uuid,
        asset_type:          recording.class.name,
        ip_uuid:             self.uuid,
        ip_type:             self.class.name,
        split:               royalty_in_pct,
        flat_rate_in_cent:   royalty_in_cent.round,
        currency:            'usd',
        email:               self.publisher.email,
        shop_product_id:     shop_product.id,
        description:         "Publishing: #{publisher.legal_name}"
      )
      
      return royalty -  royalty_in_cent.round
    rescue => e
      ErrorNotification.post_object 'PublishingAgreement#create_stake', e
      return 0.0
    end
  end
  
  def update_stake( shop_product, recording, royalty )
    Notifyer.print( 'PublishingAgreement#update_stake' , {shop_product_id: shop_product.id, recording_uuid: recording.uuid} ) if Rails.env.development?
    
    
    begin
      royalty_in_cent =  self.split * 0.01 * royalty
      royalty_in_pct  =  royalty_in_cent /  shop_product.price
      
      if stake = Stake.find_by(  
          account_id:          self.account_id,
          user_id:             self.user_id,
          ip_uuid:             self.uuid,
          ip_type:             self.class.name,
          currency:            'usd',
          #shop_product_id:     shop_product.id
        )
        stake.update_columns(
          split:               royalty_in_pct,
          flat_rate_in_cent:   royalty_in_cent.round,
          email:               self.publisher.email,
          shop_product_id:     shop_product.id,
          description:         "Publishing: #{publisher.legal_name}"
        )
      else
        Stake.create(  
          account_id:          self.account_id,
          user_id:             self.user_id,
          asset_id:            recording.uuid,
          asset_type:          recording.class.name,
          ip_uuid:             self.uuid,
          ip_type:             self.class.name,
          currency:            'usd',
          shop_product_id:     shop_product.id,
          split:               royalty_in_pct,
          flat_rate_in_cent:   royalty_in_cent.round,
          email:               self.publisher.email,
          description:         "Publishing: #{publisher.legal_name}"
        )
      end
      return royalty -  royalty_in_cent.round
    rescue => e
      ErrorNotification.post_object 'PublishingAgreement#update_stake', e
      return 0.0
    end
    
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def documents
    Document.where(belongs_to_id: self.id, belongs_to_type: self.class.name)
  end
  
  # this is the document signed by the publishing owner
  # where the owner confirms he is a valid publisher for all content connected to the publishing
  def document
    begin
      Document.cached_find(self.document_uuid)
    rescue
      nil
    end
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
  
  def update_validation 
    set_ok
    self.ipis(true).each do |ipi|
      ipi.update_validation
    end

  end
  
  def do_validation 
    return true if self.ok
    set_ok
    self.ok
  end
  
  def error_message
    em = {}
    self.documents.each do |document|
      unless document.do_validation
        em["document_#{document.id}"] = document.error_message
      end
    end
    em
  end

  private 
  
    def set_ok
      update_columns( ok: error_message.empty? ) 
    end

    def flush_cache
      update_validation unless self.destroyed?
      Rails.cache.delete([self.class.name, id])
    end
  
end
