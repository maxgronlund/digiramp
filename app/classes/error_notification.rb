module ErrorNotification
  
  def errored(error, obj)
    ap '--------------------------------------------'
    message = "#{error}: #{obj.inspect}"
    ap 'ERROR: ' + message if Rails.env.development?
    Opbeat.capture_message( message )
  end
  
  def post_error(error)
    ap '--------------------------------------------'
    ap 'ERROR: ' + error if Rails.env.development?
    Opbeat.capture_message( error )
  end
  
  def self.post_object error, obj
    ap '--------------------------------------------'
    message = "#{error}: #{obj.inspect}"
    ap 'ERROR: ' + message if Rails.env.development?
    Opbeat.capture_message( message )
  end
  
  def self.post message
    ap '--------------------------------------------'
    ap 'ERROR: ' + message if Rails.env.development?
    Opbeat.capture_message( message )
  end
  
end

# ErrorNotification.post 'some message'
# ErrorNotification.post_object 'some message', some_object