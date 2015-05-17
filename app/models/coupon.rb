class Coupon < ActiveRecord::Base
  #belongs_to :user
  belongs_to :account
  belongs_to :plan
  belongs_to :sales_coupon_batch, class_name: "Digiramp::Sales::CouponBatch"
  has_many :subscriptions
  after_create :push_to_stripe
  

  validates :stripe_id, presence: true, uniqueness: true
  validates_with CouponValidator
  
  before_destroy :remove_from_stripe
  
  serialize :stripe_object, Hash
  
  DURATION = ['forever', 'once', 'repeating']
  
  
  def push_to_stripe
    return {} if  Rails.env.test?
    
    self.redeem_by = Date.today + 3.month if self.redeem_by.blank?

    begin
      Stripe::Coupon.create(
        id:                   self.stripe_id,
        amount_off:           self.amount_off.to_i  <= 0 ? nil : self.amount_off,
        percent_off:          self.percent_off.to_i <= 0 ? nil : self.percent_off,
        duration:             self.duration,
        duration_in_months:   self.duration_in_months.to_i <= 0 ? nil : self.duration_in_months,
        currency:             self.currency,
        max_redemptions:      self.max_redemptions.to_i <= 0 ? nil : self.max_redemptions,
        redeem_by:            self.redeem_by.nil? ? nil : Time.parse(self.redeem_by.to_s).to_i
      )
    rescue Stripe::StripeError => e
      return {error: e}
    end

    #Stripe::Coupon.create(
    #  id:                   self.stripe_id,
    #  amount_off:           self.amount_off.to_i  <= 0 ? nil : self.amount_off,
    #  percent_off:          self.percent_off.to_i <= 0 ? nil : self.percent_off,
    #  duration:             self.duration,
    #  duration_in_months:   self.duration_in_months.to_i <= 0 ? nil : self.duration_in_months,
    #  currency:             self.currency,
    #  max_redemptions:      self.max_redemptions.to_i <= 0 ? nil : self.max_redemptions,
    #  redeem_by:            self.redeem_by.nil? ? nil : Time.parse(self.redeem_by.to_s).to_i
    #)
    
  end
  
  def remove_from_stripe
    self.subscriptions.update_all(coupon_id: nil)
    begin
      cpn = Stripe::Coupon.retrieve(self.stripe_id)
      cpn.delete
    rescue
    end

  end
  
  def update_times_redeemed
    if stripe_coupon       =  Stripe::Coupon.retrieve(self.stripe_id)
      self.times_redeemed = stripe_coupon.times_redeemed
      self.save
    end
  end

  
  #def self.get_code stripe_id
  #  if !stripe_id.blank?
  #    if coupon =  Coupon.find_by(stripe_id: stripe_id)
  #      return coupon.stripe_object
  #    end
  #  end
  #  return nil
  #end
end

