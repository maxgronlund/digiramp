class User::UserEmailsController < ApplicationController
  before_action :set_user_email, only: [:show, :edit, :update, :destroy]
  before_action :access_user

  def index
    @user_emails = @user.user_emails
    @email_groups = EmailGroup.all
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
      Stake.where(account_id: nil).update_all(account_id: @user.account.id, user_id: @user.id)
      @user.update_meta
      @user.save 
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
    Stake.where(email: @user_email.email).update_all(user_id: nil, account_id: nil)
    @user_email.destroy
    @user.update_meta
    @user.save
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
