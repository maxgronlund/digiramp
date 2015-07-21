class InvoiceMailer < ApplicationMailer

  def send_confirmations(shop_order_id)
    begin
      @shop_order = Shop::Order.cached_find(shop_order_id)
      send_to_sellers
      send_to_buyer
    rescue => e
      ap e.inspect
    end

  end
  
  # notify all product sellers
  def send_to_sellers
    

    @shop_order.order_items.each do |order_item|
      if product = order_item.shop_product
        if seller = product.user
          
          # http://localhost:3000/user/users/test03/order_items/8
          ##@recording_url = url_for( controller: 'recordings', action: 'show', user_id: @user.slug, id: @recording.id)
          ##@recording_url = ( URI.parse(root_url) + @recording_url ).to_s
          
          order_item_url  = url_for( controller: 'user/order_items', action: 'show', user_id: seller.slug, id: order_item.id)                           
          order_item_url = ( URI.parse(root_url) + order_item_url ).to_s
          
          #ap order_item_url
          begin
            template_name = "order-received"
            template_content = []
      
            message = {
              to: [{email: seller.email , name: seller.user_name }],
              from: {email: "noreply@digiramp.com"},
              subject: "Your have received an order ##{@shop_order.id}",
              tags: ["order", "shop"],
              track_clicks: true,
              track_opens: true,
              subaccount: '08-digiramp-orders-received',
              recipient_metadata: [{rcpt: seller.email, values: {order_id: @shop_order.id}}],
              merge_vars: [
                {
                 rcpt: seller.email,
                 vars: [ {name: "TITLE",          content: "You have sold #{product.title}"},
                         {name: "BODY",           content: "Please click on the link belove to se if you have additional action to take"},
                         {name: 'ORDER_ITEM_URL', content: order_item_url}
                      ]
                }
              ]
            }
            mandril_client.messages.send_template template_name, template_content, message
          rescue Mandrill::Error => e
            Opbeat.capture_message("#{e.class} - #{e.message}")
          end                    
                                    
        end
      end
    end

    
  end
  
  
  def send_to_buyer
    
    invoice = render_to_string('shop/invoices/notify_buyer_email', layout: 'invoices')
    #ap invoice

    begin
      template_name = "invoice"
      template_content = []
      
      message = {
        to: [{email: @shop_order.email , name: "Invoice #{@shop_order.id}" }],
        from: {email: "noreply@digiramp.com"},
        subject: "Your order invoice ##{@shop_order.id}",
        tags: ["invoice"],
        track_clicks: true,
        track_opens: true,
        subaccount: '07-digiramp-invoices',
        recipient_metadata: [{rcpt: @shop_order.email, values: {order_id: @shop_order.id}}],
        merge_vars: [
          {
           rcpt: @shop_order.email,
           vars: [ {name: "INVOICE",     content: invoice} ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end

  end
  
  
end

# InvoiceMailer.delay.send_confirmations(290) 
# InvoiceMailer.delay.send_confirmations(order.id) 