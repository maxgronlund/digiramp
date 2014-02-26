class Admin::HomesController < ApplicationController
  #before_action :set_home, only: [:show, :edit, :update, :destroy]
  #layout 'admin'

  before_filter :admins_only

  # GET /homes/1/edit
  def edit
    @home = Home.front
  end
  
  def update
    @home = Home.find(params[:id])
    @home.update(home_params)
    flash[:info] = { title: "Success", body: "Public front page updated" }
    redirect_to edit_admin_home_path(@home) 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_home
    #  @home = Home.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit! if current_user.can_edit?
    end
end
