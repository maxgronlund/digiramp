class WelcomeController < ApplicationController
  
  
  
  def index
    @ab_test =  ab_test( "landing_page", "page_a", "page_b")
    
    case @ab_test
    when "page_b"
      @body_color = "#16151D"
    when "page_a"
      @body_color = "#FFF"
    end
    # lots of requests to the db here
    
    # this is required but could it be moved to redish or external service?
    PageView.create(url: '/' )
    
    # this could be cached
    @recordings           = Recording.public_access.where(featured: true).order('featured_date desc').first(4)
    
    # shis could be cached
    @users                = User.public_profiles.where(featured: true).order('featured_date desc').first(16)
    
    # this could be cached
    @opportunities        = Opportunity.where(public_opportunity: true).first(4)
    
    
    
    # show / hide with js
    @hide_sidebar_toggle  = true
    
    # this could be optimized current_user_with_playlists
    if @user             = current_user
      @playlists         = @user.playlists
    end
    
    render( :index, page: '@ab_test')

  end
end
