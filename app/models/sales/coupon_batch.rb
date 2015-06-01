
class Sales::CouponBatch < ActiveRecord::Base
  
  # move in to module
  #ATTRIBUTES_LIST = [ :title, :body, :additional_info, :image, :price, :user_id, :account_id, :for_sale, :exclusive_offered_to_email,:show_in_shop ]
  #attr_accessor *ATTRIBUTES_LIST  
  #
  #def title
  #  'title string'
  #end
  #
  #def body
  #  'hi body text'
  #end
  #
  #def additional_info
  #  'additional info text'
  #end
  


  has_many :coupons
  has_paper_trail :only => [:email, :subject, :body, :title]
  

  #validates :title, presence: true, uniqueness: true
  validates :discount, presence: true
  validates :number_of_coupons, presence: true
  validates_with CouponBatchValidator, fields: [:coupon_code, :amount_off, :percent_off]
  validates_formatting_of :email
  
  before_destroy :remove_coupons
  before_create :initialize_uuid

  
  def initialize_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def remove_coupons
    self.coupons.destroy_all
  end
  
  def plan
    if plan = Plan.find_by(id: plan_id)
      return plan.name
    end
    nil
  end
  
  def product
    Shop::Product.find_by(uuid: self.product_uuid)
  end
  
  private
  
  
  
end


