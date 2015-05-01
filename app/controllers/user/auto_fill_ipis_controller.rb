class User::AutoFillIpisController < ApplicationController
  before_action :access_user
  def update
    @ipi = Ipi.cached_find(params[:id])         
    @ipi.full_name      = @user.user_name       if @user.user_name.to_s     != ''
    @ipi.address        = @user.address         if @user.address.to_s       != ''
    @ipi.phone_number   = @user.phone_number    if @user.phone_number.to_s  != ''
    @ipi.email          = @user.email           if @user.email.to_s         != ''
    @ipi.save!
    redirect_to edit_user_user_ipi_path(@user, @ipi)
  end
end
