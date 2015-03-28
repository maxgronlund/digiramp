class UserEmailsController < ApplicationController
  before_action :set_user_email, only: [:show, :edit, :update, :destroy]

  # GET /user_emails
  # GET /user_emails.json
  def index
    @user_emails = UserEmail.all
  end

  # GET /user_emails/1
  # GET /user_emails/1.json
  def show
  end

  # GET /user_emails/new
  def new
    @user_email = UserEmail.new
  end

  # GET /user_emails/1/edit
  def edit
  end

  # POST /user_emails
  # POST /user_emails.json
  def create
    @user_email = UserEmail.new(user_email_params)

    respond_to do |format|
      if @user_email.save
        format.html { redirect_to @user_email, notice: 'User email was successfully created.' }
        format.json { render :show, status: :created, location: @user_email }
      else
        format.html { render :new }
        format.json { render json: @user_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_emails/1
  # PATCH/PUT /user_emails/1.json
  def update
    respond_to do |format|
      if @user_email.update(user_email_params)
        format.html { redirect_to @user_email, notice: 'User email was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_email }
      else
        format.html { render :edit }
        format.json { render json: @user_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_emails/1
  # DELETE /user_emails/1.json
  def destroy
    @user_email.destroy
    respond_to do |format|
      format.html { redirect_to user_emails_url, notice: 'User email was successfully destroyed.' }
      format.json { head :no_content }
    end
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
