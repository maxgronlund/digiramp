class Shop::Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :recording
  belongs_to :playlist
  belongs_to :productable, polymorphic: true
  validates_with   ProductValidator
  validates :price, :title, :additional_info, presence: true
  
    
  
  mount_uploader :image,          ProductImageUploader
  mount_uploader :zip_file,       ZipUploader
  
  CATEGORIES = ['Product', 'Playlist', 'Streaming', 'Download', 'Service', 'Physical product', 'Coupon']
  DOWNLOAD_CATEGORIES = ["Recording", "Protools project", "Logic project", "Individual tracks (remix pack)", "Sample pack", "Graphics"]
  

  after_create :initialize_defaults
  after_commit :flush_cache
  
  #has_and_belongs_to_many :order_items, :class_name => "Shop::OrderItem"
  #has_and_belongs_to_many :orders, :class_name => "Shop::Order"
  has_many :order_items, :class_name => "Shop::OrderItem", foreign_key: "shop_product_id" 
  
  default_scope -> { order('created_at ASC') }
  scope :on_sale,  ->  { where( valid_for_sale: true).order("title asc")  }
  
  
  def product_title
    self.productable ? self.productable.title : 'na'
  end

  def seller_info
    account.user.seller_info
  end
  
  def product_image
    if self.productable_type == 'Recording'
      return sels.productable.get_shop_art
    else
      return self.image
    end
  end
  
  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def exclusive_offer?
    #if self.category == 
    ! self.exclusive_offered_to_email.blank?
  end
  
  def add_productable type, id
    self.productable_type = type
    self.productable_type = type
  end
  
  def get_item
    case self.productable_type
    when 'Recording'
      return Recording.cached_find(self.productable_id)
    end
    nil
  end
  
  def shop_image size
    case self.productable_type
      
    when 'Recording'
      recording = Recording.cached_find(self.productable_id)
      return recording.get_shop_art
    end
    #if self.category == 'recording'
    #  return self.recording.get_shop_art
    #end
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
  
  def download_url
    case self.productable_type
    when 'Recording'
      if recording = Recording.cached_find(self.productable_id)
        return recording.download_url2
      end
    end
  end
  def additional_download_url

    return nil if self.zip_file_url.nil?
    s3 = Aws::S3::Resource.new
    
    return nil if self.zip_file.nil?
    begin
      secure_url = self.zip_file_url.gsub("https://digiramp.s3.amazonaws.com/", '')
      
      file_name = File.basename(self.zip_file_url)
      
      
      bucket      = s3.bucket(Rails.application.secrets.aws_s3_bucket)
      s3_obj      = bucket.object(secure_url)
      filename    = file_name.downcase.gsub(' ', '-')
      return        s3_obj.presigned_url(:get, expires_in: 600,response_content_disposition: "attachment; filename='#{filename}'")
    rescue => e
      ErrorNotification.post "Product::additional_download_url id: #{e.inspect}"
    end
    nil
  end
  
  def stakeholders
    Stake.where(asset_type: self.class.name, asset_id: self.id)
  end
  

  
  def update_stock
    if self.units_on_stock 
      self.units_on_stock -= 1 
      self.save
      self.valid_for_sale!
    end
  end
  
  def total_stakes
    @total_share ||= get_total_share
  end
  
  def get_total_share
    total = 0.0
    self.stakeholders.each do |stakeholder|
      total += stakeholder.split
    end
    total
  end
  
  def get_shop_art thumb_size
    if self.productable
     productable.get_shop_art
    else
      self.image_url  thumb_size
    end
  end
  
  def valid_for_sale!
    begin 
      case self.category
     
      when 'recording'
        self.update( valid_for_sale: (recording.is_cleared? && connected_to_stripe) )
      when 'physical-product'
        self.update(valid_for_sale: (self.units_on_stock > 0) && connected_to_stripe)
      when 'service'
        
      end
    rescue => e
      ErrorNotification.post "Product::set_valid_for_sale: #{e.inspect}"
      self.update(valid_for_sale: false)
    end
     
  end
  
  def recording
    if self.productable_type == 'Recording'
      return Recording.cached_find(self.productable_id)
    end
  end
  

  private 
  
  #def asset_uuid
  #  case self.productable_type
  #  when 'Recording'
  #    if recording =  Recording.cached_find(self.productable_id)
  #      return recording.uuid
  #    end
  #  end
  #  nil
  #end

  
  def initialize_defaults
    Stake.create(account_id:            self.account_id, 
                    split:               100,
                    flat_rate_in_cent:   0,
                    currency:            'usd',
                    email:               self.account.user.email,
                    unassigned:          false,
                    asset_id:            self.id,
                    asset_type:          self.class.name
                    #original_source:     self.title
                   )
  end
  

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
