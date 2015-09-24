module ErrorNotification
  
  def errored(error, obj)
    message = "StripeChargeService #{error}: #{obj.inspect}"
    ap 'error: ' + message if Rails.env.development?
    Opbeat.capture_message( message )
  end
  
  def post_error(error)
    ap 'error: ' + error if Rails.env.development?
    Opbeat.capture_message( error )
  end
  
  def self.post_object error, obj
    message = "#{error}: #{obj.inspect}"
    ap 'error: ' + message if Rails.env.development?
    Opbeat.capture_message( message )
  end
  
  def self.post message
    ap 'error: ' + message if Rails.env.development?
    Opbeat.capture_message( message )
  end
  
end

# ErrorNotification.post 'some message'
# ErrorNotification.post_object 'some message', some_object