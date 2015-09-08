class User::UserIpisController < ApplicationController
  before_action :access_user
  #def show
  #  ap params
  #  @ipi = Ipi.cached_find(params[:id])
  #  @common_work = @ipi.common_work
  #  
  #end
  
  def edit
    @ipi = Ipi.cached_find(params[:id])
    @common_work = @ipi.common_work
  end
  
  
end
