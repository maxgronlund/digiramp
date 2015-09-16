class Label < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  has_many :label_recordings
  has_many :recordings,  :through => :label_recordings  
  has_many :distribution_agreements
  
  after_create :init_defaults
  
  after_commit :flush_cache
  
  
  def init_defaults
    self.update(uuid: UUIDTools::UUID.timestamp_create().to_s)
  end
  
  def configure_payment( price, rake, recording_id , distribution_agreement_id)
    
    recording = Recording.cached_find(recording_id)
    
    recording.recording_ipis.each do |recording_ipi|
      recording_ipi.configure_payment( price, rake, recording.uuid , self.id)
    end
    
  end
  
  def default_distribution_agreement
    begin 
      return DistributionAgreement.cached_find(self.default_distribution_agreement_id)
    rescue
    
    end
    nil
  end
  
  def self.create_label account_id
    account = Account.cached_find(account_id)
    begin
      label = Label.create(user_id: account.user_id, account_id: account_id, title: "#{account.user.get_full_name.strip}'s Label")
      account.user.update(default_label_id: label.id)
    rescue => e
      ErrorNotification.post_object 'Label#create_label', e
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
