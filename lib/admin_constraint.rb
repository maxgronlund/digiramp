class AdminConstraint
  def matches?(request)
    request.session[:init] = true
    return false unless request.session[:user_id]
    user = User.cached_find request.session[:user_id]
    user && user.super?
  end
end