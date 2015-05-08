class CouponValidator < ActiveModel::Validator
  def validate(record)
    
    return if record.coupon_code.blank?

    if coupon = Coupon.find_by(stripe_id: record.coupon_code)
      if coupon.id != record.coupon_id

        record.errors[:coupon_code] << 'The coupon is only valid for!'
      end
    else
      record.errors[:coupon_code] << 'Not a valid coupon code!'
    end

  end
end