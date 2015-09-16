class DistributionAgreement < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :label
  
  has_many :label_recordings
  
  after_commit :flush_cache


  def original_label
    self.distributor_id == self.label_id 
  end
  
  def distributor
    self.label
  end
  
  def configure_payment( price, recording_id )

    labels_rake               = configure_publishers_payment( price, recording_id )
    
    if self.original_label
      self.label.configure_payment( price, labels_rake, recording_id, self.id )
    else
      distributors_rake           = labels_rake * self.distribution_fee
      #distributors_rake_in_pct    distributors_rake / price
      
      self.distributor.configure_payment(     price,    distributors_rake,                 recording_id, self.id )
      self.original_label.configure_payment(  price,   (labels_rake - distributors_rake ), recording_id, self.id )
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 
  
    def configure_publishers_payment( price, recording_id )

      begin 
        recording   = Recording.cached_find(recording_id)
        common_work = recording.common_work
        labels_rake = common_work.configure_publishers_payment( price, recording.uuid )
      rescue => e
        ErrorNotification.post_object 'DistributionAgreement#pay_publishers', e
      end
      return labels_rake unless labels_rake == -1
      price
    end

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  
  
end
