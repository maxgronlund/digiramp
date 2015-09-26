# UserAssetsFactory.new user

class UserAssetsFactory
  
  def initialize user
    @user = user
    create_account
  end

  
  def create_account
   
    
    
    #return user.account if user.account
    @account = Account.new(   title: @user.user_name, 
                              user_id: @user.id, 
                              expiration_date: Date.current()>>1,
                              contact_email: @user.email,
                              visits: 1,
                              account_type: 'Social',
                              administrator_id: @user.id,
                              create_opportunities: false,
                              read_opportunities: false
                            )
                            
    # save the account without validation                        
    @account.save(validate: false)    

    AccessManager.add_users_to_new_account @account
    
    # store the account
    @user.current_account_id  = @account.id
    
    # save
    @user.save!
   
    #@account
    
    
    
    
    
    
    
    
    
    
  end
  
  def create_label
    
  end
  
  def create_publisher
    
  end
  
  def create_documents
    
  end
  
  
  
  
  
  
  
  
  
  
  
end