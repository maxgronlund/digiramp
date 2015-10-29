class User::UserConfigurationsController < ApplicationController
  before_action :set_user_configuration, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  # GET /user_configurations
  # GET /user_configurations.json
  def index
    redirect_to edit_user_user_user_configuration_path(@user, @user.user_configuration)
    #@user_configuration = @user.user_confirguration
  end

  # GET /user_configurations/1/edit
  def edit
    @body_color = "#FFFFFF"
    ap 'user_configurations/1/edit'
    ap @user.full_name
  end

  # PATCH/PUT /user_configurations/1
  # PATCH/PUT /user_configurations/1.json
  def update
    
    if params[:commit] == "Don't ask me again"
      @user_configuration.deactivated!
    else
      @user_configuration.activated!
      @user_configuration.update(user_configuration_params)
      @user_configuration.reset!
    end
    
    
    redirect_to @user
     
  end
  
  def show
    ap params[:later]
    if params[:later]
      @user_configuration.update(params[:later].to_sym => true)
    end
    #render nothing: true
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_configuration
      @user_configuration = UserConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_configuration_params
      params.require(:user_configuration).permit!
    end
    
    
end
