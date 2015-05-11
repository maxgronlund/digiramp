########################################################
# Stripe Invoice
########################################################

module StripeInvoiceService
  
  def self.subscribe events

    ########################################################
    # Invoice item CU
    ########################################################
  
  
    events.subscribe 'invoiceitem.created' do |event|
      ap '########################################################'
      ap 'invoiceitem.created'
      ap '########################################################'
      if data = event.data
        ap data
        #if object = data.object
        #  #stripe_id = object.id
        #  
        #  ap Invoice.where(   stripe_id: object.id)
        #  .first_or_create(   stripe_id:              object.id,           
        #                      stripe_object:          object.object,       
        #                      livemode:               object.livemode,            
        #                      amount_due:             object.amount_due.nil? ? nil : object.amount_due,          
        #                      attempted:              object.attempted.nil? ? nil : object.attempted,                  
        #                      closed:                 object.closed.nil? ? nil : object.closed,               
        #                      currency:               object.currency,            
        #                      stripe_customer_id:     object.customer_id,  
        #                      date:                   object.date.nil? ? nil : Date.strptime(object.date.to_s, '%s'),   
        #                      discountable:           object.discountable      
        #                      forgiven:               object.forgiven.nil? ? nil : object.forgiven,             
        #                      lines:                  object.lines.nil? ? nil : object.lines,                
        #                      paid:                   object.paid.nil? ? nil : object.paid,                 
        #                      period_start:           object.period_start.nil? ? nil : Date.strptime(object.period_start.to_s, '%s'),         
        #                      period_end:             object.period_end.nil? ? nil : Date.strptime(object.period_end.to_s, '%s'),           
        #                      starting_balance:       object.starting_balance,    
        #                      subtotal:               object.subtotal,            
        #                      total:                  object.total,               
        #                      application_fee:        object.application_fee,     
        #                      charge:                 object.charge,              
        #                      description:            object.description,         
        #                      discount:               object.discount,            
        #                      ending_balance:         object.ending_balance,      
        #                      receipt_number:         object.receipt_number,      
        #                      statement_descriptor:   object.statement_descriptor,
        #                      subscription_id:        object.subscription_id,     
        #                      metadata:               object.metadata,            
        #                      tax:                    object.tax,                 
        #                      tax_percent:            object.tax_percent,         
        #                      user_id:                object.user_id,             
        #                      account_id:             object.account_id,          
        #                      created_at:             object.created_at,          
        #                      updated_at:             object.updated_at  
        #                  )
        #  
        #  
        #  
        #  
        #  
        #end
      end
    end
  
    events.subscribe 'invoiceitem.updated' do |event|
      ap '########################################################'
      ap 'invoiceitem.updated'
      ap '########################################################'
      if data = event.data
        if object = data.object
          stripe_id = object.id
          ap Invoice.where(   stripe_id: stripe_id)
          .first_or_create(   stripe_id:              object.stripe_id,           
                              stripe_object:          object.stripe_object,       
                              livemode:               object.livemode,            
                              amount_due:             object.amount_due,          
                              attempted:              object.attempted,           
                              closed:                 object.closed,              
                              currency:               object.currency,            
                              stripe_customer_id:     object.stripe_customer_id,  
                              date:                   object.date.nil? ? nil : Date.strptime(object.date.to_s, '%s'),                
                              forgiven:               object.forgiven,            
                              lines:                  object.lines,               
                              paid:                   object.paid,                
                              period_start:           object.period_start.nil? ? nil : Date.strptime(object.period_start.to_s, '%s'),         
                              period_end:             object.period_end.nil? ? nil : Date.strptime(object.period_end.to_s, '%s'),           
                              starting_balance:       object.starting_balance,    
                              subtotal:               object.subtotal,            
                              total:                  object.total,               
                              application_fee:        object.application_fee,     
                              charge:                 object.charge,              
                              description:            object.description,         
                              discount:               object.discount,            
                              ending_balance:         object.ending_balance,      
                              receipt_number:         object.receipt_number,      
                              statement_descriptor:   object.statement_descriptor,
                              subscription_id:        object.subscription_id,     
                              metadata:               object.metadata,            
                              tax:                    object.tax,                 
                              tax_percent:            object.tax_percent,         
                              user_id:                object.user_id,             
                              account_id:             object.account_id,          
                              created_at:             object.created_at,          
                              updated_at:             object.updated_at  
                          )
        
        
        
        
        
        end
      end
    end
  


  
    ########################################################
    # Invoice CU
    ########################################################
  
  
    events.subscribe 'invoice.created' do |event|
      ap '########################################################'
      ap 'invoice.created'
      ap '########################################################'
    
    end
  
 
  
  
  
  
 
  
    events.subscribe 'invoice.payment_succeeded' do |event|
      ap '***************  invoice.payment_succeeded  ******************'
      #StripeSubscriptionMailer.receipt(stripe_event: event.data.object).deliver_now
      #ap event.data.object
      #if subscription = Subscription.where(stripe_id: event.data.object.id).first
      #StripeSubscriptionMailer.receipt(stripe_event: event.data.object).deliver_now
      #StripeSubscriptionMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_now
      #end
      #event = { stripe_event: event.data.object}
      #StripeMailer.receipt(stripe_event: event.data.object).deliver_now
      #StripeMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_now
    end
  end
  
end