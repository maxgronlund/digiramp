class StripeCustomerSubscriptionService
  def subscribe events

    events.subscribe 'customer.subscription.created' do |event|
      ap '########################################################'
      ap 'customer.subscription.created'
      ap '########################################################'
      if data = event.data
        ap 'data found'
        if stripe_object = data.object
          ap 'stripe_object found'
          ap stripe_object.id
          if  subscription = Subscription.find_by(stripe_id: stripe_object.id)
                                         #.first_or_create( stripe_id:  stripe_object.id)
                                       
            subscription.update!                             
            subscription.current_period_end        = Date.strptime(stripe_object.current_period_end.to_s, '%s')     unless stripe_object.current_period_end.nil?
            subscription.cancel_at_period_end      = stripe_object.cancel_at_period_end                        
            subscription.stripe_plan               = JSON.parse(stripe_object.plan.to_json).deep_symbolize_keys     unless stripe_object.plan.nil?
            subscription.stripe_object             = stripe_object.object                                          
            subscription.start                     = Date.strptime(stripe_object.start.to_s, '%s')                  unless stripe_object.start.nil?
            subscription.stripe_customer           = stripe_object.customer                                        
            subscription.current_period_start      = Date.strptime(stripe_object.current_period_start.to_s, '%s')   unless stripe_object.current_period_start.nil?
            subscription.ended_at                  = Date.strptime(stripe_object.ended_at.to_s, '%s')               unless stripe_object.ended_at.nil?
            subscription.trial_start               = Date.strptime(stripe_object.trial_start.to_s, '%s')            unless stripe_object.trial_start.nil?
            subscription.trial_end                 = Date.strptime(stripe_object.trial_end.to_s, '%s')              unless stripe_object.trial_end.nil?
            subscription.canceled_at               = Date.strptime(stripe_object.canceled_at.to_s, '%s')            unless stripe_object.canceled_at.nil?
            subscription.quantity                  = stripe_object.quantity
            subscription.application_fee_percent   = stripe_object.application_fee_percent
            subscription.discount                  = JSON.parse(stripe_object.discount.to_json).deep_symbolize_keys unless stripe_object.discount.nil?
            subscription.tax_percent               = stripe_object.tax_percent
            subscription.metadata                  = JSON.parse(stripe_object.metadata.to_json).deep_symbolize_keys unless stripe_object.metadata.nil?
            #subscription.email                    = 
            subscription.finish!
            subscription.save(validate: false)
            
            if user = subscription.user
              if plan = subscription.plan
                user.account_type = plan.account_type
                user.save(validate: false)
                user.account.account_type = user.account_type
                user.account.save(validate: false)
                ap 'user updated'
              end
            end
            ap 'subscription finished'
          else
            ap '============================================================='
            ap 'Outch !!!'
          end
        end
      end
    end
    
    events.subscribe 'customer.subscription.updated' do |event|
      ap '########################################################'
      ap 'customer.subscription.updated'
      ap '########################################################'
    
      if stripe_data = event.data
        if stripe_object = stripe_data.object
          ap stripe_object
        
          if stripe_plan = stripe_object.plan
            if plan = Plan.find_by(stripe_id: stripe_plan.id)
        
              if subscription = Subscription.find_by(stripe_id: stripe_object.id)
                subscription.update! 
                subscription.plan_id                   = plan.id                            
                subscription.cancel_at_period_end      = stripe_object.cancel_at_period_end                         unless stripe_object.cancel_at_period_end.nil?
                subscription.stripe_plan               = JSON.parse(stripe_object.plan.to_json).deep_symbolize_keys unless stripe_object.plan.nil?
                subscription.stripe_object             = stripe_object.object
                subscription.quantity                  = stripe_object.quantity
                subscription.application_fee_percent   = stripe_object.application_fee_percent
                subscription.discount                  = JSON.parse(stripe_object.discount.to_json).deep_symbolize_keys unless stripe_object.discount.nil?
                subscription.tax_percent               = stripe_object.tax_percent
                subscription.metadata                  = JSON.parse(stripe_object.metadata.to_json).deep_symbolize_keys unless stripe_object.metadata.nil?
              
                subscription.finish!
                subscription.save! 
                
                if user = subscription.user
                  user.account_type         = plan.account_type
                  user.save(validate: false)
                  user.account.account_type plan.account_type
                  user.account.save(validate: false)
                end
              end
            else
              Opbeat.capture_message("plan not found")
            end
          end
        end
      end
    end

    events.subscribe 'customer.subscription.deleted' do |event|
      ap '########################################################'
      ap 'customer.subscription.deleted'
      ap '########################################################'
      
      if data = event.data
        if object = data.object
          if  subscription = Subscription.find_by(stripe_id: object.id)
            ap 'subscription found'
            if user = subscription.user
              ap 'user found'
              user.account_type = 'Social'
              user.save(validate: false)
            end
            subscription.destroy
          end
        end
      end
    end
  end

end