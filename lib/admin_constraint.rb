class AdminConstraint
  def matches?(request)
    request.session[:init] = true
    return false unless request.cookies.permanent[:user_id]
    user = User.cached_find request.cookies.permanent[:user_id]
    user && user.super?
  end
end