#   usage
# 1.  add the following tree line to the parrent model
#   has_one :address
#   accepts_nested_attributes_for :address
#   include AddressMix
#
# 2. in the controller strong parameters
# address_attributes: [  :first_name,
#                        :middle_name,
#                        :last_name,
#                        :address_line_1,
#                        :address_line_2,
#                        :city,
#                        :state,
#                        :country,
#                        :id,
#                        :zip_code
#                      ]
# 3. in the form
# = f.simple_fields_for :address do |address_form|
#   = address_form.input :first_name
#   = address_form.input :middle_name
#   = address_form.input :last_name
#   = address_form.input :address_line_1
#   = address_form.input :address_line_2
#   = address_form.input :city
#   = address_form.input :state
#   = address_form.input :country
#   = address_form.input :zip_code
#   
# 4. look in views/shared/_address.slim
  
module AddressMix
  
  def address_attributes=(attributes)

    addr                   = get_address
    addr.first_name        = attributes[:first_name ]
    addr.middle_name       = attributes[:middle_name ]
    addr.last_name         = attributes[:last_name ]
    addr.address_line_1    = attributes[:address_line_1 ]
    addr.address_line_2    = attributes[:address_line_2 ]
    addr.city              = attributes[:city ]
    addr.zip_code          = attributes[:zip_code ]
    addr.state             = attributes[:state ]
    addr.country           = attributes[:country ]
    addr.save!
    @address = addr
  end

  
  def address
    @address ||=  get_address
  end
  
  def first_name()        address.first_name end
  def middle_name()       address.middle_name end
  def last_name()         address.last_name end
  def address_line_1()    address.address_line_1 end
  def address_line_2()    address.address_line_2 end
  def city()              address.city end
  def zip_code()          address.zip_code end
  def state()             address.state end
  def country()           address.country end
  
  def full_name
    [address.first_name, address.middle_name, address.last_name].join(' ').gsub('  ', ' ')
  end 

  def copy_address_to destination

    if destination.first_name.nil? && !self.first_name.nil? 
      destination.first_name = self.first_name
    end
    
    if destination.middle_name.nil? && !self.middle_name.nil? 
      destination.middle_name = self.middle_name
    end
    
    if destination.last_name.nil? && !self.last_name.nil? 
      destination.last_name = self.last_name
    end
    
    if destination.address_line_1.nil? && !self.address_line_1.nil? 
      destination.address_line_1 = self.address_line_1
    end
    
    if destination.address_line_2.nil? && !self.address_line_2.nil? 
      destination.address_line_2 = self.address_line_2
    end
    
    if destination.city.nil? && !self.city.nil? 
      destination.city = self.city
    end
    
    if destination.zip_code.nil? && !self.zip_code.nil? 
      destination.zip_code = self.zip_code
    end
    
    if destination.state.nil? && !self.state.nil? 
      destination.state = self.state
    end

    if destination.country.nil? && !self.country.nil? 
      destination.country = self.country
    end
    destination.save

  end

  
  private
  
  def get_address

    Address.where(addressable_id:           self.id, addressable_type: self.class.name)
           .first_or_create(addressable_id: self.id, 
                            addressable_type: self.class.name
                            #first_name:      '-',
                            #last_name:       '-',
                            #address_line_1:  '-',
                            #address_line_2:  '-',
                            #city:            '-',
                            #zip_code:        '-',
                            #state:           '-',
                            #country:         '-'
                            )
  end
  
  
  
end