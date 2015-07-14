class Wizard::Rights::CommonWorksController < ApplicationController

  def show
    @common_work = ::CommonWork.find(params[:id])
  end


end
