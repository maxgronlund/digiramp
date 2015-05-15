#require 'uri'

class CouponBatchMailer < ApplicationMailer
  layout 'mailer' # use mailer.(html|text).erb as the layout

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coupon_batch_mailer.send_coupon_offer.subject
  #
  def send_coupon_offer coupon_batch_id
    
    @coupon_batch = Sales::CouponBatch.find(coupon_batch_id)
    
    

    
    @link     = url_for( controller: 'shop/buy_coupons', action: 'edit', id: @coupon_batch.uuid)
    #
    #
    #
    #
    #ap @coupon_batch
    #
    #
    #@greeting = "Hi"

    mail to: @coupon_batch.email, subject: @coupon_batch.title
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coupon_batch_mailer.batch_ready.subject
  #
  def batch_ready coupon_batch_id
    @greeting = "Hi"

    mail to: "max@digiramp.com"
  end
end
