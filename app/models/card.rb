class Card < ActiveRecord::Base
  belongs_to :registration
  has_one :card_transaction

  # These attributes won't be stored
  attr_accessor :card_number, :card_verification

  before_create :validate_card

  def purchase
    subscription_fee = 0.0
    #if account_features = AccountFeature.where(account_type: registration.account_type).first
    #  subscription_fee = account_features.subscription_fee
    #end
    
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    create_card_transaction(action: "purchase", amount: price_in_cents, response: response)
    if response.success?
      
      notification_params = { "invoice"       => Registration.get_new_invoice_id, 
                              "first_name"    => registration.full_name,
                              "quantity"      => registration.quantity,
                              "mc_gross"      => registration.subscription_fee,
                              "payment_gross" => registration.subscription_fee * registration.quantity
      
                            }
      registration.update_attributes(purchased_at: Time.now, notification_params: notification_params, status: 'Completed') 
    end
    response.success?
  end

  def price_in_cents
    ( registration.subscription_fee * 100 ).round
  end

  private

  def purchase_options
    account = self.registration.account
    {
      
        ip: ip_address,
        billing_address: {
            name:      registration.company,
            address1:  registration.address1,
            city:      registration.city,
            state:     registration.state,
            country:   registration.country,
            zip:       registration.zip
        }
    }
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add :base, message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        brand:               card_type,
        number:              card_number,
        verification_value:  card_verification,
        month:               card_expires_on.month,
        year:                card_expires_on.year,
        first_name:          first_name,
        last_name:           last_name
    )
  end
end
