# replacement for AuthorizationProvider to store in a cookie

class Authorization
  
  attr_accessor :info
  
  #create_table "authorization_providers", force: true do |t|
  #  t.string   "provider"
  #  t.string   "uid"
  #  t.integer  "user_id"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #  t.string   "oauth_token"
  #  t.datetime "oauth_expires_at"
  #  t.boolean  "oauth_expires"
  #  t.text     "info"
  #  t.string   "oauth_secret"
  #end

  def initialize options={}
    @info = options
  end
  
  #def where(provider: env.provider, uid: env.uid)
  # replacement for 'where'
  def get_provider options={}
    
    
    user_uuid:  options.user_uuid, 
    provider:   options.provider
    
    # get cookie here
    
    
    
  end
  
  
  
  
  
end