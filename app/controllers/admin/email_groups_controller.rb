class Admin::EmailGroupsController < ApplicationController
  before_action :set_email_group, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only
  def index
    @email_groups = EmailGroup.all
  end

  def show
  end

  def new
    @email_group = EmailGroup.new
  end

  def edit
  end

  def create
    @email_group = EmailGroup.new(email_group_params)
    @email_group.save!
    redirect_to admin_email_group_path @email_group
  end

  def update
    if @email_group.update(email_group_params)
      redirect_to admin_email_group_path @email_group
    end

  end

  def destroy
    @email_group.destroy
    redirect_to admin_email_groups_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_group
      @email_group = EmailGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_group_params
      params.require(:email_group).permit(:title, :body, :email_recipients )
    end
end
