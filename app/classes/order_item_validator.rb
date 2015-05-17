class OrderItemValidator < ActiveModel::Validator
  def validate(record)
    

    ap record
    
    if record.quantity < 1
      record.errors[:quantity] << "Quantity can't be less than 1"
    end
    
    

    
    #return if record.coupon_code.blank?
    #
    #if coupon = Coupon.find_by(stripe_id: record.coupon_code)
    #  if record.plan_id != coupon.plan_id
    #    record.errors[:coupon_code] << 'The coupon is not valid for this account type!'
    #  elsif  coupon.redeem_by < Date.today
    #    record.errors[:coupon_code] << 'The coupon is expired!'
    #  end
    #else
    #  record.errors[:coupon_code] << 'Not a valid coupon code!'
    #end

  end
end