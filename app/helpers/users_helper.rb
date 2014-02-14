module UsersHelper
  
  def admin_users_path_backbone *args
    admin_users_path(*args)+"#admin_users"
  end
  
  def can_edit?
    user_signed_in? && current_user.super?
  end
  
  def user_signed_in?
    current_user != nil
  end
  
  def current_user_is_max?
    can_edit? && current_user.email == 'max@synthmax.dk'
  end
  
  def profile_path_for user
    path = user_path( user)
  end
  
end
