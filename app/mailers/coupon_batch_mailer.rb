require 'uri'

class CouponBatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coupon_batch_mailer.send_coupon.subject
  #
  def send_coupon coupon_batch_id
    @greeting = "Hi"

    mail to: "max@digiramp.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coupon_batch_mailer.batch_ready.subject
  #
  def batch_ready coupon_batch_id
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
