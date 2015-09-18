# look inside AddressMix

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  #validates :first_name,:last_name, :address_line_1, :city, :country, presence: true
  def empty?
    return false if !self.first_name.nil?
    return false if !self.middle_name.nil?
    return false if !self.last_name.nil?
    return false if !self.address_line_1.nil?
    return false if !self.address_line_2.nil?
    return false if !self.city.nil?
    return false if !self.zip_code.nil?
    return false if !self.state.nil?
    return false if !self.country.nil?
    true
  end
  
end
