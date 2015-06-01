class StripeData
  
  def self.get event


    if stripe_data = event.data
      if stripe_object = stripe_data.object
        return stripe_object
      end
    else 
      Opbeat.capture_message("Stripe:Data #{event.inspect}")
    end

  end

  
end