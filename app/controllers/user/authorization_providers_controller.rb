class User::AuthorizationProvidersController < ApplicationController
  before_filter :access_user
  def index
    @authorized = false
    if current_user.id == @user.id || current_user.super?
      @authorized = true
    end
  end



  def destroy
    authorization_provider = AuthorizationProvider.find(params[:id])
    authorization_provider.destroy
    redirect_to user_user_authorization_providers_path(@user)
  end
end
