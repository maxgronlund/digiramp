class OrderPayment

  def self.set_address_fields_from_payment_source( order )
    
    if order_content = order.order_content
      if payment_source      = order_content[:payment_source]
         order.card_address_name      =  payment_source[:name]
         order.card_address_line_1    =  payment_source[:address_line1]
         order.card_address_line_2    =  payment_source[:address_line2]
         order.card_address_state     =  payment_source[:state]
         order.card_address_city      =  payment_source[:address_city]
         order.card_address_zip       =  payment_source[:address_zip]
         order.card_address_country   =  payment_source[:address_country]
      end
    end
  end

end

# OrderPayment.set_address_fields_from_payment_source( Shop::Order.last)