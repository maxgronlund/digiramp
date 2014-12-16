class Admin::OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy, :music_submissions]
  
  before_filter :admin_only

  
  def index
    @opportunities  = Opportunity.search(params[:query]).order('deadline desc').page(params[:page]).per(50)
    @user   = current_user
    @authorized = true
  end


  
end