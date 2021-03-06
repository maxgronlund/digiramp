class Admin::HelpsController < ApplicationController
  before_action :set_help, only: [:show, :edit, :update, :destroy]
  
  include UsersHelper
  before_action :editor_only

  # GET /helps
  # GET /helps.json
  def index
    @helps = Help.all
  end

  # GET /helps/1
  # GET /helps/1.json
  def show
  end

  # GET /helps/new
  def new
    @help = Help.new
  end

  # GET /helps/1/edit
  def edit
  end

  # POST /helps
  # POST /helps.json
  def create
    @help = Help.create(help_params)

    redirect_to admin_helps_path
  end

  # PATCH/PUT /helps/1
  # PATCH/PUT /helps/1.json
  def update
    params[:help][:user_id] = current_user.email
     @help.update(help_params)
     if go_to = session[:return_url]
       session[:return_url] = nil
       redirect_to go_to
     else
       redirect_to admin_helps_path
     end
  end

  # DELETE /helps/1
  # DELETE /helps/1.json
  def destroy
    @help.destroy
    redirect_to admin_helps_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help
      @help = Help.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_params
      params.require(:help).permit(:identifier, :button, :title, :body, :snippet, :email) if editor?
    end
end
