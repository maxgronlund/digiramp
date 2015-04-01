class Confirmation::WrongUsersController < ApplicationController
  def show
    @ipi  = Ipi.where(uuid: params[:uuid]).first
    @user = current_user
  end
end
