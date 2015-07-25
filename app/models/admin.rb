class Admin < ActiveRecord::Base
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def raise_accounts_version
    flush_cache
    self.accounts_version += 1
    save!
  end
  
  def self.get_invoice_nr
    admin = Admin.first_or_create
    admin.update(orders_count: admin.orders_count + 1)
    admin.orders_count
  end
  
end


# Admin.get_invoice_nr