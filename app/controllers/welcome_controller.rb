class WelcomeController < ApplicationController
  def index
    @recordings =  Recording.public_access.last(4)
    @users      =  User.public_profiles.order('followers_count desc').first(16)
  end
end
