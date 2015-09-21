class Label < ActiveRecord::Base
  
  mount_uploader :image, LogoUploader
  validates :title, presence: true
  
  belongs_to :user
  belongs_to :account
  
  has_many :label_recordings
  has_many :recordings,  :through => :label_recordings  
  has_many :distribution_agreements
  before_destroy :remove_from_shop
  after_create :init_defaults
  after_commit :flush_cache
  
  
  def init_defaults
    self.update(uuid: UUIDTools::UUID.timestamp_create().to_s)
  end
  
  def default_distribution_agreement
    begin
      if @distribution_agreement = DistributionAgreement.find_by(id: self.default_distribution_agreement_id)
      else
        @distribution_agreement = DistributionAgreement.create(
        :label_id => self.id,
                           :account_id => self.account_id,
                       :distributor_id => self.id,
                              :royalty => 10,
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
  
  def configure_payment( price, rake, recording_id , distribution_agreement_id)
   
    
    ipis_rake = configure_distribution_payment( 
      price, 
      rake, 
      recording_id , 
      distribution_agreement_id 
    )
    configure_ipi_fee( 
      price, 
      ipis_rake, 
      recording_id 
    )
  end
  
  def configure_ipi_fee( price, ipis_rake, recording_id )
    
    begin
      recording = Recording.cached_find(recording_id)
      
      recording.recording_ipis.each do |recording_ipi|
        recording_ipi.configure_payment( price, ipis_rake, recording.uuid )
      end
    rescue => e
      ErrorNotification.post_object 'Label#configure_payment', e
    end
    
  end
  
  
  def configure_distribution_payment( price, rake, recording_id , distribution_agreement_id )
    
    begin
      distribution_agreement = DistributionAgreement.cached_find(distribution_agreement_id)
      distribution_rake      = rake * distribution_agreement.split * 0.01
      
      
      amount_in_cent =  distribution_rake
      amount_in_pct  =  amount_in_cent /  price
      
      #ap "amount_in_cent: #{amount_in_cent}"
      #ap "royalty; #{royalty}"
      recording = Recording.cached_find(recording_id)

      if stake = Stake.find_by( 
          account_id:         self.account.id,
          asset_id:           recording.uuid,
          asset_type:         'Recording',
          ip_uuid:            distribution_agreement.uuid,
          ip_type:            'DistributionAgreement'
        )
        stake.update(
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent,
          currency:            'usd',
          email:               self.user.email,
          unassigned:          false
        )
      else
        stake = Stake.create(  
          account_id:          self.account.id,
          asset_id:            recording.uuid,
          asset_type:          'Recording',
          ip_uuid:             distribution_agreement.uuid,
          ip_type:             'DistributionAgreement',
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent,
          currency:            'usd',
          email:               self.user.email,
          unassigned:          false
        )
      end
      return rake - distribution_rake
    rescue => e
      ErrorNotification.post_object 'Label#configure_distribution_payment', e
      return rake
    end
  end

  
  def remove_from_shop
    self.distribution_agreements.each do |distribution_agreement|
      distribution_agreement.remove_from_shop
    end
  end

  def self.create_label account_id
    account = Account.cached_find(account_id)
    #begin
      label = Label.create( user_id: account.user_id, account_id: account_id, title: "#{account.user.get_full_name}'s Label")
      account.user.update(default_label_id: label.id)
    #rescue => e
    #  ErrorNotification.post_object 'Label#create_label', e
    #end
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
