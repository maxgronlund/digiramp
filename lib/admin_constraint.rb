class AdminConstraint
  def matches?(request)
    puts '**************************************************************************'
    puts request.session.inspect
    puts '**************************************************************************'
    request.session[:init] = true
    return false unless request.session[:user_id]
    user = User.find request.session[:user_id]
    user && user.super?
  end
end