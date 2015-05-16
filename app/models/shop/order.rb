class Shop::Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :stripe_customer
end
