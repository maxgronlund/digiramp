class Authorization
  
  attr_accessor :info
  def initialize options={}
    #puts options
    @info = options
  end
  
end

options = {c: 'c', d: 'd'}
a = Authorization.new(options)
#a.info = {c: 'c', d: 'd'}

puts a.info