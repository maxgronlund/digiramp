class ProfessionalInfo < ActiveRecord::Base
  belongs_to :user
  has_one :address
  accepts_nested_attributes_for :address
  
  def address_attributes=(attributes)
    addr = get_address
    addr.first_name        = attributes[:first_name ]
    addr.middle_name       = attributes[:middle_name ]
    addr.last_name         = attributes[:last_name ]
    addr.address_line_1    = attributes[:address_line_1 ]
    addr.address_line_2    = attributes[:address_line_2 ]
    addr.city              = attributes[:city ]
    addr.state             = attributes[:state ]
    addr.country           = attributes[:country ]
    addr.save!
    @address               = nil
  end

  
  def address
    @address ||=  get_address
  end
  
  private
  
  def get_address
    Address.where(addressable_id:           self.id, addressable_type: self.class.name)
           .first_or_create(addressable_id: self.id, 
                            addressable_type: self.class.name,
                            first_name:      '-',
                            last_name:      '-',
                            address_line_1: '-',
                            address_line_2: '-',
                            city:           '-',
                            state:          '-',
                            country:        '-')
  end
end
