class CreditCard
  
  def self.years
     years = *( Time.now.year.to_i.. Time.now.year.to_i+14 )
  end
  
  def self.months
    months = []
    name = ["01 Jan","02 Feb","03 Mar","04 Apr","05 May","06 June","07 July","08 Aug","09 Sep","10 Oct","11 Nov","12 Dec"]
    name.each_with_index {|name, index| months << "#{name[index]} (#{ format('%02d', index+1)})" }
  end
end

# CreditCard.years
# CreditCard.months
