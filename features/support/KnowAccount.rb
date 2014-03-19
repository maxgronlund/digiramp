

module KnowAccountHelper
  
  def create_account title, name, email, password, role
  
    @user          = User.where(email: email).first_or_create( email: email, password: password, password_confirmation: password, role: role, name: name)
    @account       = User.create_a_new_account_for_the @user
    @account.title = title
    @account.save!
  end
  
end

World(KnowAccountHelper)




