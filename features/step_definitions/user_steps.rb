Given(/^there is an administrator for "(.*?)" with the name "(.*?)" email "(.*?)" password "(.*?)"$/) do |account_title, name, email, password|
  account = Account.where(title: account_title).first
  
  administrator = User.create( email: email, 
                      name: name, 
                      password: password, 
                      password_confirmation: password,
                      activated: true,
                      role: 'cuctomer')
                      
                      
  
  administrators_account            = User.create_a_new_account_for_the administrator
  administrators_account.title      = "#{name} account"
  administrators_account.save!
  administrator.current_account_id  = administrators_account.id
  administrator.save
  
  account_user = AccountUser.create(user_id: administrator.id, 
                                    account_id: account.id,  
                                    role: "Administrator")
  
  
end

Given(/^these users without an activated account:$/) do |customers_table|
  create_un_activated_customers customers_table.raw
end

Given(/^these users with an activated account:$/) do |customers_table|
   create_activated_customers customers_table.raw
end