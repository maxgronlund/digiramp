class Shop::Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :recording
  belongs_to :playlist
  
  
  validates :price, :title, :body, :additional_info, presence: true
  
    
  validates_with ProductValidator
  mount_uploader :image,    ProductImageUploader
  mount_uploader :zip_file,     ZipUploader
  
  CATEGORIES = ['Product', 'Playlist', 'Streaming', 'Download', 'Service', 'Physical product', 'Coupon']
  DOWNLOAD_CATEGORIES = ["Recording", "Protools project", "Logic project", "Individual tracks (remix pack)", "Sample pack", "Graphics"]
  
  
  
  before_save :populate_uuid
  
  #has_and_belongs_to_many :order_items, :class_name => "Shop::OrderItem"
  #has_and_belongs_to_many :orders, :class_name => "Shop::Order"
  has_many :order_items, :class_name => "Shop::OrderItem"
  
  def seller_info
    user.seller_info
  end
  
  after_commit :flush_cache

  def self.cached_find(uuid)
    Rails.cache.fetch([name, uuid]) { find_by(uuid: uuid) }
  end
  
  def exclusive_offer?
    #if self.category == 
    ! self.exclusive_offered_to_email.blank?
  end
  
  def add_productable type, id
    self.productable_type = type
    self.productable_type = type
  end
  
  def shop_image size
    if self.category == 'recording'
      return self.recording.get_shop_art
    end
    self.image_url(size)
    
  end
  
  
  def self.attach record, product_params = {}

    product = Shop::Product.create(  title:                         product_params[:title], 
                                     body:                          product_params[:body], 
                                     additional_info:               product_params[:additional_info], 
                                     price:                         product_params[:price],
                                     exclusive_offered_to_email:    product_params[:exclusive_offered_to_email],
                                     download_link:                 product_params[:download_link],
                                     user_id:                       product_params[:user_id],
                                     account_id:                    product_params[:account_id],
                                     units_on_stock:                product_params[:units_on_stock],
                                     for_sale:                      product_params[:for_sale],
                                     image:                         product_params[:image],
                                     productable_id:                record.id,      
                                     productable_type:              record.class.name      
                                     
                                  )

    
  end
  
  def additional_download_url
    s3 = Aws::S3::Resource.new
    secure_url = ''
    return '' if self.zip_file.nil?
    begin
      secure_url = self.zip_file_url.gsub("https://digiramp.s3.amazonaws.com/", '')
      
      file_name = File.basename(self.zip_file_url)
      
      
      bucket      = s3.bucket(Rails.application.secrets.aws_s3_bucket)
      s3_obj      = bucket.object(secure_url)
      filename    = file_name.downcase.gsub(' ', '-')
      secure_url  = s3_obj.presigned_url(:get, expires_in: 600,response_content_disposition: "attachment; filename='#{filename}'")
    rescue => e
      ap e.inspect
      secure_url = ''
    end
    secure_url
  end
  
  def stakeholders
    stakes = []
    
    case self.category
      
    when 'recording'
      recording.stakes.each do |stake|
        stakes << {user_id: stake.user_id, split: stake.split_in_percent, account_id: stake.account_id}
        ap stakes
      end
    else
      #RecordingStakeholdersService.assign_recording_stakes ({recording_id: self.recording.id, user_id: self.account_id} )
      stakes << {user_id: self.user_id, split: 1.0 , account_id: self.account_id }
    end
    
    
    stakes

  end
  
  def update_stock
    if self.units_on_stock 
      self.units_on_stock -= 1 
      save
    end
  end
  

  private 
  

  
  def populate_uuid
    if new_record?
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
  end
  

  def flush_cache
    Rails.cache.delete([self.class.name, uuid])
  end
end
