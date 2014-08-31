class User::AuthorizationProvidersController < ApplicationController
  before_filter :access_user
  def index
  end



  def destroy
    authorization_provider = AuthorizationProvider.find(params[:id])
    authorization_provider.destroy
    redirect_to user_user_authorization_providers_path(@user)
  end
end
