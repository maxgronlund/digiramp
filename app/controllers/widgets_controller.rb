class WidgetsController < ApplicationController
  before_action :set_widget, only: [ :edit, :update, :destroy]


  def index
    if params[:account]
      @account = params[:account]
      @widgets = @account.widgets
    end
  end


  def show
    @widget = Widget.where(secret_key: params[:id]).first

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
