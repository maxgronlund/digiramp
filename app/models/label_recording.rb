class LabelRecording < ActiveRecord::Base
  belongs_to :label
  belongs_to :recording
  
  belongs_to :distribution_agreement
  
  #def receive_payment payment
  #  begin
  #    self.distribution_agreement.receive_payment( payment, self.recording_id )
  #  rescue => e
  #    ErrorNotification.post_object 'LabelRecording#receive_payment', e
  #  end
  #end
  
  # when changes is made in the ips or recording_ipis 
  # payments has to be reconfigured
  def self.configure_payment( recording_id )
    begin
      if label_recordings = LabelRecording.where(recording_id: recording_id)
        self.update_all_recordings( label_recordings )
      end
    rescue => e
      ErrorNotification.post_object 'LabelRecording#configure_payment', e
    end
  end
  
  
  # update all recordings 
  def self.update_all_recordings label_recordings
    
    label_recordings.each do |label_recording|
      label_recording.update_shop_products
    end
  end
  
  def update_shop_products
    ap 'LabelRecording#update_shop_products'
    if shop_products = Shop::Product.where(productable_id: self.recording_id, productable_type: 'Recording')
      ap 'shop_products found'
      shop_products.each do |shop_product|
        if shop_product.distribution_agreement
          # go ahead and reconfigure all ips
          shop_product.distribution_agreement.configure_payment( shop_product.price, shop_product.recording)
          # check 
          shop_product.valid_for_sale!
          ap '------- end ----------'
        end
      end
    end
  end

end


# LabelRecording.configure_payment( recording_id )