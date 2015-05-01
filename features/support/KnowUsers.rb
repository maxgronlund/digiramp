module KnowUsersHelper

  def find_or_create_user  name, email, password, role
    return @user if @user = user_with_email( email )

    @user       = FactoryGirl.create(:user, email: email, password: password, role: role)
    @account    = User.create_a_new_account_for_the @user
    
  end
  
  def user_with_email email
    User.where(email: email).first
  end
  
  #def create_user role, first_name, last_name , email, password, super_user
  #  user = User.new()
  #  user.first_name = first_name
  #  user.last_name  = last_name
  #  user.role       = role
  #  
  #  user.super_user = super_user
  #  user.save  validate: false
  #  user.profile = MemberProfile.new email: email, password: password, password_confirmation: password
  #  user.email      = email
  #  user.profile.save!
  #  user.save  validate: false
  #end
  
end

World(KnowUsersHelper)