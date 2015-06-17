class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  validates :first_name,:last_name, :address_line_1, :city, :country, presence: true
  
  #enum address_type: { default: 0, billing: 1, shipping: 2 }
end
