# look inside AddressMix

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  #validates :first_name,:last_name, :address_line_1, :city, :country, presence: true
  
  
end
