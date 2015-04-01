class User::UserEmailsController < ApplicationController
  before_action :set_user_email, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  def index
    @user_emails = @user.user_emails
  end


  def show
  end


  def new
    @user_email = UserEmail.new
  end


  def edit
  end


  def create
    @user_email = UserEmail.new(user_email_params)
    if @user_email.save
      redirect_to user_user_user_emails_path(@user, @user_email)
    else
      render :new
    end

  end

  def update
    if @user_email.update(user_email_params)
      redirect_to user_user_user_emails_path(@user)
    else
      render :edit
    end
  end


  def destroy
    @user_email.destroy
    redirect_to user_user_user_emails_path(@user)
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_email
      @user_email = UserEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_email_params
      params.require(:user_email).permit(:email, :user_id)
    end
end
