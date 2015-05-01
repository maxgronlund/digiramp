class User::ConfirmIpisController < ApplicationController
  before_action :access_user

  def index
    @ipis = @user.ipis
    
  end
  
  def show
    @ipi = Ipi.cached_find(params[:id])
  end
  
end