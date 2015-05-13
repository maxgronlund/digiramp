class Sales::CouponBatch < ActiveRecord::Base
  #has_many :coupons
  

  validates :title, presence: true, uniqueness: true
  validates :discount, presence: true
  validates :number_of_coupons, presence: true
  validates_with CouponBatchValidator, fields: [:coupon_code, :amount_off, :percent_off]
  validates_formatting_of :email
  
  before_destroy :remove_coupons
  before_create :initialize_uuid
  
  def initialize_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  attr_accessor :stripe_id,
                :amount_off,
                :percent_off,
                :duration,
                :duration_in_months,
                :currency,
                :number_of_coupons,
                :times_redeemed,
                :metadata,
                :redeem_by,
                :plan_id,
                :account_id,
                :stripe_object,
                :sales_coupon_batch_id
                
  def coupons
    Coupon.where(sales_coupon_batch_id: self.id)
  end
  
  def remove_coupons
    self.coupons.destroy_all
  end
end


