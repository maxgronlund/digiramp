class DiscoverController < ApplicationController
  def index
    @users      = User.public_profiles.order('followers_count desc').first(32)
    @recordings = Recording.public_access.order('created_at desc').first(32)
  end
end
