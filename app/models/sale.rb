class Sale < ActiveRecord::Base
  has_paper_trail
  include AASM
  
  belongs_to :product
  before_save :populate_guid
  validates_uniqueness_of :guid
  
  validates :amount, :stripe_token, :email,:product_id, presence: true
  
  aasm column: 'state' do
    state :pending, initial: true
    state :processing
    state :finished
    state :errored
    event :process, after: :charge_card do
      transitions from: :pending, to: :processing
    end
    
    event :finish do
      transitions from: :processing, to: :finished
    end
    
    event :fail do
        transitions from: :processing, to: :errored
    end
  end
  

  
  def formatted_price
    sprintf("$%0.2f", self.amount / 100.0)
  end
  
  private
  
    def populate_guid
      if new_record?
        while !valid? || self.guid.nil?
          self.guid = UUIDTools::UUID.timestamp_create().to_s
        end
      end
    end
    
    def charge_card
      #' Sale#charge_card'
      save!
      begin
        
        charge = Stripe::Charge.create(
          amount: self.amount,
          currency: "usd",
          source: self.stripe_token,
          description: self.email,
        )

        balance = Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
        source  = charge.source.exp_month
        self.update(
                      stripe_id: charge.id,
                      card_expiration: Date.new( charge.source.exp_year, charge.source.exp_month, 1),
                      fee_amount: balance.fee
                    )
        self.finish!
        
      rescue Stripe::StripeError => e
        self.update_attributes(error: e.message)
        self.fail!
      end
    end

end