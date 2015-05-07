class StripeMailer < ActionMailer::Base
  default from: 'max@pixelsonrails.com'
  
  def admin_dispute_created(arg)
    
    #@charge = charge
    #@sale   = Sale.find_by(stripe_id: @charge.id)
    #if @sale
    #  mail(to: 'max@pixelsonrails.com', subject: "Dispute created on charge #{@sale.guid} (#{charge.id})").
    #  deliver
    #end
  end
  
  def admin_charge_succeeded(arg)
    ap 'admin_charge_succeeded'
    ap arg
    #stripe_event = arg[:stripe_event]
    #ap stripe_event
    #@charge = arg[:stripe_event]
    #@sale   = Sale.find_by( stripe_id: @charge.id )
    #if @sale
    #  mail(to: 'max@pixelsonrails.com', subject: 'Woo! Charge Succeeded!')
    #end
  end
  
  def receipt(arg)
    ap 'receipt'
    ap arg
    #if stripe_event = arg[:stripe_event]
    #  
    #  if @user =  User.where(stripe_customer_id: stripe_event.customer).first
    #    if @statement_descriptor = stripe_event.statement_descriptor
    #      if @amount = stripe_event.amount
    #         mail(to: @user.email, subject: "#{@statement_descriptor} invoice #{Date.today}")
    #      end
    #    end
    #  end
    #end
    #
    
    #"cus_67GA9pKmY9xWsj"
    #@charge = arg[:stripe_event]
    #@sale = Sale.find_by!( stripe_id: @charge.id )
    #if @sale
    #  mail(to: @sale.email, subject: "Thanks for purchasing #{@sale.product.name}")
    #end
  end
  
  def subscription_updated(digiramp_subscription_id)
    ap 'subscription_updated'
    if @digiramp_subscription = Subscription.find_by(id: digiramp_subscription_id)
      if @user = @digiramp_subscription.user
        if @email = @user.email
          # fix this digiramp_subscription.account_type do not exist
          #mail(to: @email, subject: "Your DigiRAMP plan has changed to #{@digiramp_subscription.account_type} -#{Date.today}")
        end
      end
    end
    #ap arg
    #if stripe_event = arg[:stripe_event]
    #  if stripe_id = stripe_event.id
    #    if subscription = Subscription.find_by(stripe_id: stripe_id)
    #      subscription.cancel_at_period_end
    #      if stripe_plan = stripe_event.plan
    #        ap stripe_plan.statement_descriptor
    #      end
    #    end
    #  end
    #  ap stripe_event.current_period_end
    #  ap User.find_by(stripe_id: stripe_event.customer)
    #end
     #ap stripe_event
    #if @user =  User.where(stripe_customer_id: stripe_event.customer).first
    #  if plan  =  stripe_event.plan
    #    ap stripe_event.cancel_at_period_end
    #    if @plan_name = plan.name
    #      mail(to: @user.email, subject: "Your DigiRAMP plan has changed to #{@plan_name} -#{Date.today}")
    #    end
    #  end
    #end
    
  end
  
  def subscription_canceled(digiramp_subscription_id)
     ap 'subscription_canceled'
     if @digiramp_subscription = Subscription.find_by(id: digiramp_subscription)
       if @user = @digiramp_subscription.user
         if @email = @user.email
           # fix this digiramp_subscription.account_type do not exist
           #mail(to: @email, subject: "Your DigiRAMP plan has changed to #{@digiramp_subscription.account_type} -#{Date.today}")
         end
       end
     end
  end
  

  
end