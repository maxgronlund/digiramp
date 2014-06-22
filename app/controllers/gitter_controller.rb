class GitterController < ApplicationController
  def index
    ap params
    @title  = params[:title]
    @mesage = params[:message]
    @time   = params[:time]
    @sticky = params[:sticky]
    @image  = params[:image]
  end
end


