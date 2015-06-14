#require 'uri'

class CouponBatchMailer < ApplicationMailer
  layout 'mailer' # use mailer.(html|text).erb as the layout


  def send_coupon_offer coupon_batch_id
    
    @coupon_batch = Sales::CouponBatch.find(coupon_batch_id)
    @link         = url_for( controller: 'shop/buy_coupons', action: 'show', id: @coupon_batch.uuid)

    mail to: @coupon_batch.email, subject: @coupon_batch.title
  end

  def batch_ready coupon_batch_id
    @greeting = "Hi"
    mail to: "max@digiramp.com"
  end
end
