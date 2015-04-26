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
    stripe_event = arg[:stripe_event]
    #ap stripe_event
    #@charge = arg[:stripe_event]
    #@sale   = Sale.find_by( stripe_id: @charge.id )
    #if @sale
    #  mail(to: 'max@pixelsonrails.com', subject: 'Woo! Charge Succeeded!')
    #end
  end
  
  def receipt(arg)
    if stripe_event = arg[:stripe_event]
      if @user =  User.where(stripe_customer_id: stripe_event.customer).first
        if @statement_descriptor = stripe_event.statement_descriptor
          if @amount = stripe_event.amount
             mail(to: @user.email, subject: "#{@statement_descriptor} invoice #{Date.today}")
          end
        end
      end
    end
    
    
    #"cus_67GA9pKmY9xWsj"
    #@charge = arg[:stripe_event]
    #@sale = Sale.find_by!( stripe_id: @charge.id )
    #if @sale
    #  mail(to: @sale.email, subject: "Thanks for purchasing #{@sale.product.name}")
    #end
  end
  
  def subscription_updated(arg)
    if stripe_event = arg[:stripe_event]
       #ap stripe_event
      if @user =  User.where(stripe_customer_id: stripe_event.customer).first
        if plan =  stripe_event.plan
          
          
          
          
          
          
          
          #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          
          
          
          
          
          
          
          
          ap stripe_event.cancel_at_period_end
          if @plan_name = plan.name
            mail(to: @user.email, subject: "Your DigiRAMP plan has changed to #{@plan_name} -#{Date.today}")
          end
        end
      end
    end
  end
  

  
end