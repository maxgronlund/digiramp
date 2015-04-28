class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :plan
  #before_save :populate_guid
  validates_uniqueness_of :guid
  #validates :cardholders_name, presence: true
  has_paper_trail
  include AASM
  

  
  aasm column: 'state' do
    state :pending, initial: true
    state :processing
    state :updating_cc
    state :updating_plan
    state :finished
    state :errored

    
    
    event :process, after: :charge_card do
      transitions from: :pending, to: :processing
    end
    
    event :finish do
      transitions from: :processing, to: :finished
    end
    
    #event :finish do
    #  transitions from: :updating_cc, to: :finished
    #end
    
    event :fail do
      transitions from: :processing, to: :errored
    end
    
    event :reset do
      transitions from: :errored, to: :finished
    end
    
    event :update do
      transitions from: :finished, to: :processing
    end
    
    event :update_cc do
      transitions from: :finished, to: :processing
    end
    
    event :source_deleted do
      transitions from: :processing, to: :updating_cc
    end
    
    event :source_created do
      transitions from: :updating_cc, to: :finished
    end
  end
  

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def change_plan plan_id

    self.error = ''
    self.update!
    
    # start a job to check if validation from stripe went true
    StripeCheckUpdateJob.set(wait: 3.minute).perform_later(self.guid)
    
    # notice plan will be updated from stripe_event.rb hook
    if plan = Plan.cached_find(plan_id)
      
      begin
        stripe_customer          = Stripe::Customer.retrieve(self.user.stripe_customer_id)
        stripe_subscription      = stripe_customer.subscriptions.retrieve(self.stripe_id)
        stripe_subscription.plan = plan.stripe_id
        stripe_subscription.save

      rescue Stripe::StripeError => e
        self.error << e.message
        
        self.save
        self.fail!
        self.reset!
        return e.message
      end
    else
      ap 'plan not found'
    end
    nil
  end
  
  def cancel_when_plan_expires
    begin
      
      customer      = Stripe::Customer.retrieve(self.user.stripe_customer_id)
      subscription  = customer.subscriptions.retrieve(self.stripe_id)
      subscription.delete(at_period_end: true)
      #customer.subscriptions.retrieve(self.stripe_id).delete
    rescue Stripe::StripeError => e
      return e.message
    end
    nil
  end
  
  #def update_card
  #  save!
  #  
  #end
  

private 
  #def populate_guid
  #  if new_record?
  #    while !valid? || self.guid.nil?
  #      self.guid = UUIDTools::UUID.timestamp_create().to_s
  #    end
  #  end
  #end
  
  def charge_card
    save!

    begin
      stripe_sub = nil
    
      if self.user.stripe_customer_id.blank?
        customer                      = Stripe::Customer.create( source:  self.stripe_token, 
                                                                 email:   self.user.email, 
                                                                 plan:    self.plan.stripe_id
                                                                )
        self.user.stripe_customer_id  = customer.id
        self.user.save!
        stripe_sub                    = customer.subscriptions.first
      else                            
        customer                      = Stripe::Customer.retrieve(self.user.stripe_customer_id)
        stripe_sub                    = customer.subscriptions.create( plan: self.plan.stripe_id )
      end
      self.stripe_id = stripe_sub.id
      self.save!
      self.finish!
    rescue Stripe::StripeError => e
      ap e.message
      self.update_attributes(error: e.message)
      self.fail!
    end
  end
  
  
  
  def create_stripe_customer
    
    
  end
  
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
