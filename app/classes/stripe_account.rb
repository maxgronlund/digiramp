class StripeAccount
  
  def self.info user
    begin
      acct =  Stripe::Account.retrieve(user.stripe_id.to_s)

      return { 
                id:                     acct["id"],
                email:                  acct["email"],
                statement_descriptor:   acct["statement_descriptor"],
                display_name:           acct["display_name"],
                timezone:               acct["timezone"],
                country:                acct["country"],
                business_name:          acct["business_name"],
                business_url:           acct["business_url"],
                support_phone:          acct["support_phone"],
                payment_gateway:        'stripe',
                user_id:                user.id
              }

    rescue Stripe::StripeError => e
      ap e.message
      Opbeat.capture_message( e.message )
    end
    nil
  end
end


#StripeAccount.info