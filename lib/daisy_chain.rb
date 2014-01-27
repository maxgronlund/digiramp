class Object
  def daisy_chain method, options
    obj = self
    options[:times].times do
      obj = obj.public_send(method)
    end
    obj
  end
end