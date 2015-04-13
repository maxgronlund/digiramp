class Registration < ActiveRecord::Base
  belongs_to :account
  has_one :card
  accepts_nested_attributes_for :card
  after_commit :flush_cache
  #validates :full_name, :company, :email, :telephone, presence: true

  serialize :notification_params, Hash
  def paypal_url(return_path)
    item_number = 0
    if account_feature = AccountFeature.where(account_type: self.account_type).first
      item_number = account_feature.id + 1
    end
    values = {
        business:     "max-facilitator@pixelsonrails.com",
        cmd:          "_xclick",
        upload:       1,
        return:       "#{ENV["APP_HOST"]}#{return_path}.pdf",
        invoice:      id + 22345,
        amount:       self.subscription_fee,
        item_name:    self.account_type + ' account subscription',
        item_number:  item_number,
        quantity:     self.quantity,
        notify_url:  "#{ENV["APP_HOST"]}/user/users/#{account.user.slug}/hook"
    }
    "#{ENV["PAYPAL_HOST"]}/cgi-bin/webscr?" + values.to_query
  end

  def payment_method
    if card.nil? then "paypal"; else "card"; end
  end
  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
