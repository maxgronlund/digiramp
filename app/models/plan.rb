class Plan < ActiveRecord::Base
  has_paper_trail
  
  has_many :account_features
  has_many :subscriptions
  has_many :coupons
  
  INTERVALS = ['day', 'week', 'month',  'year']
  CURRENCY  = ['usd']
  
  before_destroy :remove_from_subscriptions
  before_save :populate_stripe_id
  validates :stripe_id, uniqueness: true
  
  def remove_from_subscriptions
    account_features.update_all(plan_id: nil)
    subscriptions.update_all(plan_id: nil) if self.subscriptions
  end
  
  
  def populate_stripe_id
    if new_record?
      while !valid? || self.stripe_id.nil?
        self.stripe_id = 'DigiRAMP-' + SecureRandom.random_number(1_000_000_000).to_s(36)
      end
    end
  end

  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 
    after_commit :flush_cache
    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
