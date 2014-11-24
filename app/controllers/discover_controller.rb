class DiscoverController < ApplicationController
  def index
    @users = User.public_profiles.order('followers_count desc').first(20)
  end
end
