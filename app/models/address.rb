class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  enum address_type: { default: 0, billing: 1, shipping: 2 }
end
