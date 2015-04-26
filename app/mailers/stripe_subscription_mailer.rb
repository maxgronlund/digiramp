class StripeSubscriptionMailer < ActionMailer::Base
  default from: 'max@pixelsonrails.com'
  
  def admin_dispute_created(charge)
    
    ap @charge = charge
    #@sale   = Sale.find_by(stripe_id: @charge.id)
    #if @sale
    #  mail(to: 'max@pixelsonrails.com', subject: "Dispute created on charge #{@sale.guid} (#{charge.id})").
    #  deliver
    #end
  end
  
  def admin_charge_succeeded(arg)
    stripe_event = arg[:stripe_event]
    ap stripe_event
    #@sale   = Sale.find_by(stripe_id: @charge.id)
    #if @sale
    #  mail(to: 'max@pixelsonrails.com', subject: 'Woo! Charge Succeeded!')
    #end
  end
  
  def receipt(arg)
    stripe_event = arg[:stripe_event]
    ap stripe_event
    #@sale = Sale.find_by!(stripe_id: @charge.id)
    #mail(to: @sale.email, subject: "Thanks for purchasing #{@sale.product.name}")
  end
  

  
end