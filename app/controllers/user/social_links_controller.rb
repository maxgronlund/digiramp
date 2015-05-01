class User::SocialLinksController < ApplicationController
  before_action :access_user
  def edit
  end
  
  def update
    params[:user][:link_to_facebook]      = LinkValidator.sanitize( params[:user][:link_to_facebook   ] )
    params[:user][:link_to_twitter]       = LinkValidator.sanitize( params[:user][:link_to_twitter    ] )
    params[:user][:link_to_linkedin]      = LinkValidator.sanitize( params[:user][:link_to_linkedin   ] )
    params[:user][:link_to_google_plus]   = LinkValidator.sanitize( params[:user][:link_to_google_plus] )
    params[:user][:link_to_tumblr]        = LinkValidator.sanitize( params[:user][:link_to_tumblr     ] )
    params[:user][:link_to_instagram]     = LinkValidator.sanitize( params[:user][:link_to_instagram  ] )
    params[:user][:link_to_youtube]       = LinkValidator.sanitize( params[:user][:link_to_youtube    ] )
    params[:user][:link_to_homepage]      = LinkValidator.sanitize( params[:user][:link_to_homepage   ] )

    if @user.update(user_params)
      redirect_to user_user_control_panel_index_path(@user)
    else
      render :edit
    end
  end
  
private

  def user_params
    params.require(:user).permit!
  end
end
