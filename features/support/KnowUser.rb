module KnowUsersHelper

  #def find_or_create_user role, first_name, last_name , email, password
  #  @user = User.where(email: email).first
  #  super_user = role == 'super'
  #  role = 'admin' if role == 'super'
  #  @user = create_user( role, first_name, last_name , email, password, super_user ) unless @user
  #  @user
  #end
  #
  #def get_user_with_email email
  #  MemberProfile.where(email: email).first.user
  #end
  #
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
  
  def digiramp_administrator
    @user = User.where(email: 'admin@digiramp.com').first_or_create( email: 'admin@digiramp.com', password: 'admin', password_confirmation: 'admin', role: 'super')
  end
  
end

World(KnowUsersHelper)