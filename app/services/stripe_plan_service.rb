########################################################
# Stripe Plam
########################################################

class StripePlanService
  
  def subscribe events

    # Created
    events.subscribe 'plan.created' do |event|
      ap '########################################################'
      ap 'plan.created'
      ap '########################################################'
    end
    
    
    events.subscribe 'plan.deleted' do |event|
      ap '########################################################'
      ap 'plan.deleted'
      ap '########################################################'
      stripe_id = event.data.object.id
      if  plan = Plan.where(stripe_id: stripe_id).first
        plan.destroy
      end
    end
  end
end