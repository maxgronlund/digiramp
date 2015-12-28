class Label < ActiveRecord::Base
  
  has_one :address
  accepts_nested_attributes_for :address
  include AddressMix
  
  mount_uploader :image, LogoUploader
  validates :title, presence: true, uniqueness: true
  
  belongs_to :user
  belongs_to :account
  
  has_many :label_recordings
  has_many :recordings,  :through => :label_recordings  
  has_many :distribution_agreements
  before_destroy :remove_from_shop
  after_create :init_defaults
  after_commit :flush_cache
  
  
  def init_defaults
    self.update( 
      uuid: UUIDTools::UUID.timestamp_create().to_s
    )
  end
  
  def default_distribution_agreement
    begin
      if @distribution_agreement = DistributionAgreement.find_by(id: self.default_distribution_agreement_id)
      else
        @distribution_agreement = DistributionAgreement.create(
                             :label_id => self.id,
                           :account_id => self.account_id,
                       :distributor_id => self.id,
                                :split => 100,
                              :user_id => self.user_id,
                                :title => "#{self.user.full_name} distribution agreement",
                                 :uuid => UUIDTools::UUID.timestamp_create().to_s
        
        )
        self.update(default_distribution_agreement_id: @distribution_agreement.id)
      end
      @distribution_agreement
    rescue => e
      ErrorNotification.post_object 'Label#default_distribution_agreement', e
    end
  end
  
  def create_stake amount_in_cent, shop_product, recording , distribution_agreement

    Notifyer.print( 'Label#create_stake' , amount_in_cent: amount_in_cent ) if Rails.env.development?
    
    amount_in_pct = amount_in_cent / shop_product.price
    begin
      Stake.create(  
        account_id:          self.account.id,
        user_id:             self.user_id,
        asset_id:            recording.uuid,
        asset_type:          'Recording',
        ip_uuid:             distribution_agreement.uuid,
        ip_type:             'DistributionAgreement',
        split:               amount_in_pct,
        flat_rate_in_cent:   amount_in_cent.round,
        currency:            'usd',
        email:               self.user.email,
        unassigned:          false,
        shop_product_id:     shop_product.id,
        description:         "Label: #{self.title}"
      )
    rescue => e
      ErrorNotification.post_object 'Label#create_stake', e
    end
  end
  
  
  def update_stake amount_in_cent, shop_product, recording , distribution_agreement

    Notifyer.print( 'Label#update_stake' , amount_in_cent: amount_in_cent ) if Rails.env.development?
    
    amount_in_pct = amount_in_cent / shop_product.price
    
    begin
      if stake = Stake.find_by(  
          account_id:          self.account.id,
          user_id:             self.user_id,
          asset_id:            recording.uuid,
          asset_type:          'Recording',
          ip_uuid:             distribution_agreement.uuid,
          ip_type:             'DistributionAgreement',
          #shop_product_id:     shop_product.id,
        )
        stake.update_columns(  
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent.round,
          currency:            'usd',
          email:               self.user.email,
          shop_product_id:     shop_product.id,
          description:         "Label: #{self.title}"
        )
      else
      
        stake = Stake.create(  
          account_id:          self.account.id,
          user_id:             self.user_id,
          asset_id:            recording.uuid,
          asset_type:          'Recording',
          ip_uuid:             distribution_agreement.uuid,
          ip_type:             'DistributionAgreement',
          unassigned:          false,
          shop_product_id:     shop_product.id,
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent.round,
          currency:            'usd',
          email:               self.user.email,
          shop_product_id:     shop_product.id,
          description:         "Label: #{self.title}"
        )
      end
      
      flush_cache
    rescue => e
      ErrorNotification.post_object 'Label#update_stake', e
    end
  end

  def remove_from_shop
    self.distribution_agreements.each do |distribution_agreement|
      distribution_agreement.remove_from_shop
    end
  end


  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
