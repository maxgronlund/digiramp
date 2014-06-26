class GitterController < ApplicationController
  def index
    @title  = params[:title]
    @mesage = params[:message]
    @time   = params[:time]
    @sticky = params[:sticky]
    @image  = params[:image]
  end
end


