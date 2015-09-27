class DistributionAgreement < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :label
  
  
  has_many :label_recordings
  has_many :recordings,  :through => :label_recordings  
  has_many :recording_ipis
  
  after_commit :flush_cache


  def documents
    Document.where(belongs_to_id: self.id, belongs_to_type: self.class.name)
  end
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
    distribution_rake    = configure_publishers_payment( price, recording_id )

    
    if self.original_label
      self.label.configure_payment( 
        price, 
        distribution_rake, 
        recording_id, 
        self.id 
      )
    else
      #!!!
      self.distributor.configure_distribution_payment( 
        price,   
        distribution_rake,               
        recording_id, 
        self.uuid 
      )
      self.label.configure_payment(             
        price,   
        distribution_rake , 
        recording_id, self.uuid 
      )
    end
  end
  
  def connect_to_label

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
        recording       = Recording.cached_find(recording_id)
        common_work     = recording.common_work
        return common_work.configure_publishers_payment( price, recording.uuid )
      rescue => e
        return price
        ErrorNotification.post_object 'DistributionAgreement#pay_publishers', e
      end

    end
  

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  
  
end
