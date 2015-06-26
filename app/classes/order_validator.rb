class OrderValidator < ActiveModel::Validator
  
  def self.check_validity_on order

    return 'Your basket is empty' if order.order_items.count == 0
    msg = check_shop_items_on( order )
    ap msg
    return msg if msg 

  end
  
  def self.check_shop_items_on order

    order.order_items.each do |order_item|
      
      product = order_item.product
      
      if product.nil?
        order_item.destroy
        return 'A product has been deleted' 
      end 
      msg = update_units_on_order_item( product, order_item )
      return msg if msg
    end
    false   
  end
  
  def self.update_units_on_order_item( product, order_item )
    
    return false if product.units_on_stock.nil?

    if product.units_on_stock < 0
      return 'Sorry a product on your order just went out of stock'
    end
    
    test = product.units_on_stock - order_item.quantity
    
    if test < 0
      order_item.quantity += test
      order_item.save
      return "Sorry we only have #{order_item.quantity} units on stock"
    end
    false
  end
  
  
  def self.set_units_on_order_item(order_item, quantity)

    if product = order_item.product
      
      test = product.units_on_stock - quantity
      ap test
      if test < 0
        quantity =  quantity + test
      end
      
    end
    order_item.quantity = quantity
    order_item.save
  end
  
end

# OrderValidator.check_validity_on order
# OrderValidator.check_units_on( shop_item )