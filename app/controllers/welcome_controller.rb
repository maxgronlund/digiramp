class WelcomeController < ApplicationController
  def index
    #if current_user
    #  redirect_to user_path current_user
    #else
    PageView.create(url: '/' )
    @recordings           =  Recording.public_access.where(featured: true).order('featured_date desc').first(4)
    @users                =  User.public_profiles.where(featured: true).order('featured_date desc').first(16)
    @opportunities        = Opportunity.where(public_opportunity: true).first(4)
    @playlists            = current_user.playlists if current_user
    @hide_sidebar_toggle  = true
    @user                 = current_user
    #end
  end
end
