class DistributionAgreement < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :label
  
  
  has_many :label_recordings
  has_many :recordings,  :through => :label_recordings  
  has_many :recording_ipis
  
  after_commit :flush_cache


  def original_label
    #ap 'original label'
    #ap "self.label_id: #{self.label_id}"
    #ap "self.distributor_id: #{self.distributor_id}"
    self.distributor_id == self.label_id 
  end
  
  def distributor
    begin
      return Label.cached_find(self.distributor_id)
    rescue
      self.update(distributor_id: self.id)
      return self
    end
  end
  
  def configure_payment( price, recording_id )

    labels_rake               = configure_publishers_payment( price, recording_id )
    
    if self.original_label
      self.label.configure_payment( price, labels_rake, recording_id, self.id )
    else
      distributors_rake           = labels_rake * self.distribution_fee * 0.01
      #distributors_rake_in_pct    distributors_rake / price
      
      self.distributor.configure_distribution_fee( price,    distributors_rake,                 recording_id, self.id )
      self.label.configure_payment(                price,   (labels_rake - distributors_rake ) * 0.01, recording_id, self.id )
    end
  end
  
  def connect_to_label
    
    ap "connect_to_label"
    if distributor_label = Label.find_by(uuid: distribution_agreement_uuid)
      self.update(distributor_id: distributor_label.id)
    else
      self.update(distributor_id: self.label.id)
    end
  end
  
  def remove_from_shop
    if shop_products = Shop::Product.where( distribution_agreement_id: distribution_agreement.id)
      shop_products.update_all(valid_for_sale: false)
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
