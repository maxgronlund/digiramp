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
  
  def configure_distribution_fee( price, rake, recording_id , distribution_agreement_id)
    ap '---------------------------------------'
    ap 'configure_distribution_fee'
    
    
    ap "price: #{price}"
    ap "rake: #{rake}"
    ap "recording_id: #{recording_id}"
    
    #begin
    #  
    #  if stake = Stake.find_by( account_id:         self.account_id,
    #                            asset_id:           recording_uuid,
    #                            asset_type:         'Recording',
    #                            ip_uuid:            self.uuid,
    #                            ip_type:            self.class.name
    #                           )
    #                           
    #    stake.update(
    #                 split:               self.share * share_after_publishers,
    #                 flat_rate_in_cent:   0,
    #                 currency:            'usd',
    #                 email:               self.user.email,
    #                 unassigned:          false,
    #                 expired:             false
    #                 
    #                 )
    #  else
    #    stake = Stake.create(  account_id:          self.account_id,
    #                           asset_id:            recording_uuid,
    #                           asset_type:          'Recording',
    #                           ip_uuid:             self.uuid,
    #                           ip_type:             self.class.name,
    #                           split:               self.share * share_after_publishers,
    #                           flat_rate_in_cent:   0,
    #                           currency:            'usd',
    #                           email:               self.user.email,
    #                           unassigned:          false,
    #                           expired:             false
    #                        )
    #  end
    #  
    #  #ap stake
    #rescue => e
    #  ErrorNotification.post_object 'RecordingIpi#configure_payment', e
    #  
    #end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  end
  
  def configure_payment( price, rake, recording_id , distribution_agreement_id)
    
    recording = Recording.cached_find(recording_id)
    
    recording.recording_ipis.each do |recording_ipi|
      recording_ipi.configure_payment( price, rake, recording.uuid , self.id)
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
      label = Label.create( user_id: account.user_id, account_id: account_id, title: "#{account.user.get_full_name.strip}'s Label")
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
