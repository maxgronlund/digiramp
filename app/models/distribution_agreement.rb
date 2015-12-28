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
  
  def create_stakes shop_product, recording
    Notifyer.print( 'DistributionAgreement#create_stakes' , original_label: self.original_label ) if Rails.env.development?
    
    begin
      common_work     = recording.common_work
      create_publishers_stakes( common_work, shop_product, recording )
      label_cut       = ( shop_product.price - common_work.royalty) * self.split * 0.01
      
      if self.original_label
        self.label.create_stake( 
          label_cut, 
          shop_product,
          recording, 
          self 
        )
      else
      end
      label_and_publishings_cut  = label_cut + common_work.royalty
      
      return label_and_publishings_cut
    rescue => e
      ErrorNotification.post_object 'DistributionAgreement#create_stake', e
      return 0.0
    end
  end
  
  def update_stakes shop_product, recording
    Notifyer.print( 'DistributionAgreement#update_stakes' , original_label: self.original_label ) if Rails.env.development?
    
    begin
      common_work     = recording.common_work
      update_publishers_stakes( common_work, shop_product, recording )
      label_cut       = ( shop_product.price - common_work.royalty) * self.split * 0.01
      
      if self.original_label
        self.label.update_stake( 
          label_cut, 
          shop_product,
          recording, 
          self 
        )
      else
      end
      label_and_publishings_cut  = label_cut + common_work.royalty
      
      return label_and_publishings_cut
    rescue => e
      ErrorNotification.post_object 'DistributionAgreement#create_stake', e
      return 0.0
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
    
    # send money to the publishers and return the remainding
    def create_publishers_stakes( common_work, shop_product, recording )
      Notifyer.print( 'DistributionAgreement#create_publishers_stakes' , shop_product: shop_product ) if Rails.env.development?
      begin 
        common_work.create_publishers_stakes( shop_product, recording )
      rescue => e
        ErrorNotification.post_object 'DistributionAgreement#create_publishers_stakes', e
      end
    end
    
    def update_publishers_stakes( common_work, shop_product, recording )
      Notifyer.print( 'DistributionAgreement#update_publishers_stakes' , shop_product: shop_product ) if Rails.env.development?
      begin 
        common_work.update_publishers_stakes( shop_product, recording )
      rescue => e
        ErrorNotification.post_object 'DistributionAgreement#update_publishers_stakes', e
      end
    end
    
    
    
    
    
    
    # obsolete
    def configure_publishers_payment( shop_product )
    end
  

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  
  
end
