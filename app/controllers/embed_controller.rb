class EmbedController < ApplicationController
  
  def index
    
  end
  
  def show
    # make this a little more prity
    @widget = Widget.where(secret_key: params[:id]).first
    #@layout = WidgetTheme.first
    #begin
    #  @layout = WidgetTheme.where(id: @widget.layout).first
    #rescue
    #  @layout = WidgetTheme.first
    #end

  end
end
