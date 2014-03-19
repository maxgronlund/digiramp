module KnowUsersHelper

  
  def create_un_activated_customers customers_table
    customers_table.each do |customer_row|
      secret_password = '123456'
      user            = User.create(  name: customer_row[0], 
                                      email: customer_row[1], 
                                      password:  secret_password, 
                                      password_confirmation: secret_password, 
                                      role: 'cuctomer',
                                      activated: false)
                                      
      account = User.create_a_new_account_for_the user
      account.activated = false
      account.save
    end
  end
  
  def create_activated_customers customers_table
    customers_table.each do |customer_row|
      secret_password = '123456'
      user            = User.create(  name: customer_row[0], 
                                      email: customer_row[1], 
                                      password:  customer_row[3], 
                                      password_confirmation: customer_row[3], 
                                      role: 'cuctomer',
                                      activated: true)
                                    
      account = User.create_a_new_account_for_the user
      account.title = customer_row[2]
      account.save!
    end
  end
end

World(KnowUsersHelper)