class Registration < ActiveRecord::Base
  belongs_to :account
  has_one :card
  accepts_nested_attributes_for :card

  #validates :full_name, :company, :email, :telephone, presence: true

  serialize :notification_params, Hash
  def paypal_url(return_path)
    
    values = {
        business: "test01@pixelsonrails.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{ENV["APP_HOST"]}#{return_path}",
        invoice: id + 12345,
        amount:       account.subscribtion_price,
        item_name:    account.title,
        item_number:  account.id,
        quantity: '1',
        notify_url: "#{ENV["APP_HOST"]}/hook"
    }
    "#{ENV["PAYPAL_HOST"]}/cgi-bin/webscr?" + values.to_query
  end

  def payment_method
    if card.nil? then "paypal"; else "card"; end
  end
end
