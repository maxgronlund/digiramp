class PublishersController < ApplicationController
  def index
    @publishers = Publisher.where(show_on_public_page: true)
    @user = current_user
  end
  
  def show
    @publisher = Publisher.cached_find(params[:id])
    @user      = current_user
  end
end
