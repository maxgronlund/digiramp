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

  end
  
  def receipt(arg)

  end
  
  def subscription_updated(digiramp_subscription_id)
    # 'subscription_updated'
    if @digiramp_subscription = Subscription.find_by(id: digiramp_subscription_id)
      if @user = @digiramp_subscription.user
        if @email = @user.email
          # fix this digiramp_subscription.account_type do not exist
          #mail(to: @email, subject: "Your DigiRAMP plan has changed to #{@digiramp_subscription.account_type} -#{Date.today}")
        end
      end
    end

    
  end
  
  def subscription_canceled(digiramp_subscription_id)
     # 'subscription_canceled'
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