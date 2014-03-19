class Customer < ActiveRecord::Base
  
  include PgSearch
  pg_search_scope :search_customer, against: [:name, :email, :note, :phone], :using => [:tsearch]
  
  belongs_to :account
  has_many :customer_events
  
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end


  
  def self.search( query)
    if query.present?
      return Customer.search_customer(query)
    else
      return all
    end
  end
  


private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    account.customer_cache_version += 1
    account.save!
  end

  
end
