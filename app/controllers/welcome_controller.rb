class WelcomeController < ApplicationController
  def index
    #if current_user
    #  redirect_to user_path current_user
    #else
    @recordings =  Recording.public_access.where(featured: true).order('featured_date desc').first(4)
    @users      =  User.public_profiles.where(featured: true).order('featured_date desc').first(16)
    @opportunities = Opportunity.where(public_opportunity: true).first(4)
    #end
  end
end
