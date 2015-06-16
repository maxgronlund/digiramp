class CouponBatchMailer < ApplicationMailer
 
  def send_coupon_offer coupon_batch_id
    coupon_batch = Sales::CouponBatch.find(coupon_batch_id)
    email        = coupon_batch.email
    title        = coupon_batch.title
    subject      = coupon_batch.subject
    body         = coupon_batch.body
    link         = url_for( controller: 'shop/buy_coupons', action: 'show', id: coupon_batch.uuid)

    begin
      template_name = "coupon-offer"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: subject,
        tags: ["coupon", "offer"],
        track_clicks: true,
        track_opens: true,
        subaccount: "03-digiramp-coupon-offers",
        recipient_metadata: [{rcpt: email, values: {coupon_batch_id: coupon_batch_id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",       content: title},
                   {name: "BODY",        content: body },
                   {name: "LINK",        content: link }
                   ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
  end

  def batch_ready coupon_batch_id
    @greeting = "Hi"
    mail to: "max@digiramp.com"
  end
end
