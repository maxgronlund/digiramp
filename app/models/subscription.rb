class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :plan
  has_many   :payment_sources
  #before_save :populate_guid
  #validates :email, presence: true
  validates_formatting_of :email, :using => :email, :allow_nil => false
  validates_uniqueness_of :guid
  #validates :cardholders_name, presence: true
  has_paper_trail
  include AASM
  
  serialize :stripe_plan, Hash
  serialize :discount, Hash
  serialize :metadata, Hash

  
  before_destroy :remove_payment_sources
  
  def remove_payment_sources
    payment_sources.destroy_all unless payment_sources.blank?
  end
  

  
  aasm column: 'state' do
    state :pending, initial: true
    state :processing
    #state :updating_cc
    state :updating_plan
    state :finished
    state :errored

    
    
    event :process, after: :charge_card do
      transitions from: :pending, to: :processing
    end

    event :update do
      transitions from: :finished, to: :processing
    end
    
    event :finish do
      transitions from: :processing, to: :finished
    end
    
    event :fail do
      transitions from: :processing, to: :errored
    end
    
    event :reset do
      transitions from: :errored, to: :finished
    end
    
  end
  
  def reset_state
    self.reset!           if self.state == 'errored'
    self.finish!          if self.state == 'processing'
    #self.source_created!  if self.state == 'updating_cc'
  end
  

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def change_plan plan_id

    self.error = ''
    self.update!
    
    # start a job to check if validation from stripe went true
    #StripeCheckUpdateJob.set(wait: 3.minute).perform_later(self.guid)
    
    # notice plan will be updated from stripe_event.rb hook
    new_plan = Plan.cached_find(plan_id)
      
    begin
      stripe_customer          = Stripe::Customer.retrieve(self.user.stripe_customer_id)
      stripe_subscription      = stripe_customer.subscriptions.retrieve(self.stripe_id)
      stripe_subscription.plan = new_plan.stripe_id
      stripe_subscription.save
      self.finish!
      self.save
      return 'Your plan has been changed. You will receive an confirmation email'
    rescue Stripe::StripeError => e
      self.error << e.message
      self.save
      self.fail!
      return e.message
    end

  end
  
  def cancel_when_plan_expires
    ap 'cancel_when_plan_expires'
    self.reset_state
    self.update!
    self.cancel_at_period_end = true

    begin
      if stripe_customer      = Stripe::Customer.retrieve(self.user.stripe_customer_id)
        if stripe_subscriptions = stripe_customer.subscriptions
          stripe_subscription  = stripe_subscriptions.retrieve(self.stripe_id)
          stripe_subscription.delete(at_period_end: true)
        end
      end
      self.finish!
      
      # send subscription canceled email
      
      ap self
      return "You have cancled your current plan, it will continue until the period you have paied for expires" 
    rescue Stripe::StripeError => e
      self.fail!
      self.error = e.message
      return 'An error occurred. You will be contacted by support'
    end
    self.save!
    
    
    # send subscription canceled email
    
  end
  

private 

  
  def charge_card
    save!
    begin
      stripe_sub = nil
      # the customer is not in stripe
      if self.user.stripe_customer_id.blank?
        # this will create a customer and a subscription
        customer               = Stripe::Customer.create( source:  self.stripe_token, 
                                                          email:   self.email, 
                                                          plan:    self.plan.stripe_id
                                                         )
        self.user.stripe_customer_id  = customer.id
        self.user.save!

        stripe_sub                    = customer.subscriptions.first
      else 
        # there is already a customer in the stripe system                           
        customer                      = Stripe::Customer.retrieve(self.user.stripe_customer_id)
        # create the subscription
        stripe_sub                    = customer.subscriptions.create( plan: self.plan.stripe_id )
      end

      # store the stripe is for future payments
      self.stripe_id                  = stripe_sub.id
      self.error = ''
      self.save!
      self.finish!
      ap self
    rescue Stripe::StripeError => e
      ap e.message
      self.update_attributes(error: e.message)
      self.fail!
    end
  end
  
 
  

  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
