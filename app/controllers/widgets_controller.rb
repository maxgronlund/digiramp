class WidgetsController < ApplicationController
  #before_action :set_widget, only: [ :edit, :update, :destroy]
  before_filter :get_user, only: [:show, :edit, :update, :new, :create, :destroy, :index]

  def index
    #if current_user && current_user.id == @user.id
    #  #@recordings =  Recording.recordings_search(@user.recordings, params[:query]).order('uniq_title asc').page(params[:page]).per(4)
    #else
    #  #@recordings =  Recording.public_access.recordings_search(@user.recordings, params[:query]).order('uniq_title asc').page(params[:page]).per(4)
    #end
    
    @widgets  = @user.widgets
  end


  def show
    #@widget = Widget.where(secret_key: params[:id]).first
    @widget = Widget.cached_find(params[:id])
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_params
      params.require(:widget).permit!
    end
end
