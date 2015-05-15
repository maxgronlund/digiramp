class CouponValidator < ActiveModel::Validator
  def validate(record)
    

    #if record.discount && !record.discount.between?(0, 100)
    #  record.errors[:discount] << 'Discount has to bee in the range 0-100 '
    #end
    
    if record.amount_off && record.amount_off.to_i < 0
      record.errors[:amount_off] << 'Amount off has to be a positive integer '
    end
    
    if record.percent_off.blank? && record.amount_off.blank?
      record.errors[:amount_off] << 'Both amount off and percent off cant be blank'
      record.errors[:percent_off] << 'Both amount off and percent off cant be blank'
    end
    
    unless record.percent_off.blank?
       unless record.percent_off.to_i.between?(1, 100)
         record.errors[:percent_off] << 'Percent off off has to bee in the range 1-100 '
       end
    end
    
    #if record.number_of_coupons.to_i < 1
    #  record.errors[:number_of_coupons] << "Number of coupons can't be less than 1" 
    #end
  
    if record.duration == 'repeating' 
      if record.duration_in_months.blank?
        record.errors[:duration_in_months] << "You have to set duration in month" 
      elsif record.duration_in_months.to_i < 1
        record.errors[:duration_in_months] << "Duration in month can't be less than 1" 
      end
    end
    
    if  record.redeem_by.blank?
      record.errors[:redeem_by] << 'Redeem by has to be filled in!'
    elsif  record.redeem_by < Date.today
      record.errors[:redeem_by] << 'The coupon is expired!'
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