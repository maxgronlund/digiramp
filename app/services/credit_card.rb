class CreditCard
  
  def self.years
     years = *( Time.now.year.to_i.. Time.now.year.to_i+14 )
  end
  
  def self.months
    months = []
    name = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"]
    name.each_with_index {|name, index| months << "#{name[index]} (#{ format('%02d', index+1)})" }
  end
end

# CreditCard.years
# CreditCard.months
