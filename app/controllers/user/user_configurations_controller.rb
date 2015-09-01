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
  end

  # PATCH/PUT /user_configurations/1
  # PATCH/PUT /user_configurations/1.json
  def update
    
    if params[:commit] == "Don't ask me again"
      ap '----------------------------------------'
      @user_configuration.deactivated!
    else
      @user_configuration.activated!
      @user_configuration.update(user_configuration_params)
    end
    
    
    redirect_to @user
     
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_configuration
      @user_configuration = UserConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_configuration_params
      params.require(:user_configuration).permit( :user_id, 
                                                  :i_want_to_promote_my_music,
                                                  :i_want_to_sell_music, 
                                                  :i_want_to_get_my_music_into_films_and_tv, 
                                                  :i_want_to_sell_goods, 
                                                  :i_want_to_find_and_listen_to_music,
                                                  :i_want_to_offer_services, 
                                                  :i_want_to_collaborate, 
                                                  :i_want_to_manage_users_and_catalogs, 
                                                  :i_want_to_build_custom_web_pages,
                                                  :dont_ask_me_again, 
                                                  :configured)
    end
    
    
end
