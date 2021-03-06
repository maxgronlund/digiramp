

class Admin::DigirampEmailsController < ApplicationController
  before_action :set_digiramp_email, only: [:show, :edit, :update, :destroy]
  before_action :admin_only
  
  def index
    @digiramp_emails = DigirampEmail.all
  end

  def show
     @email_group    = EmailGroup.find(params[:email_group_id])
    #@unsibscribe_link = url_for unsubscribe_index_path(uuid: @digiramp_email.email_group.uuid)
    @unsibscribe_link =    unsubscribes_path(uuid: @digiramp_email.email_group.uuid)
  end

  def new
    @email_group    = EmailGroup.find(params[:email_group_id])
    @digiramp_email = DigirampEmail.new
  end

  def edit
    
    @email_group    = EmailGroup.find(params[:email_group_id])
    if @digiramp_email.delivered
      redirect_to admin_email_group_digiramp_email_path( @digiramp_email.email_group, @digiramp_email)
    end
  end

  def create
    @digiramp_email = DigirampEmail.new(digiramp_email_params)
    if @digiramp_email.save
      redirect_to edit_admin_email_group_digiramp_email_path( @digiramp_email.email_group, @digiramp_email)
    end
  end

  # PATCH/PUT /digiramp_emails/1
  # PATCH/PUT /digiramp_emails/1.json
  def update
    @email_group    = EmailGroup.find(params[:email_group_id])

    @digiramp_email.update(digiramp_email_params)
    
    if params[:commit] == "Deliver"
      @digiramp_email.send_news_emails
    end

    redirect_to admin_email_group_path( @email_group )
  end

  # DELETE /digiramp_emails/1
  # DELETE /digiramp_emails/1.json
  def destroy
    @email_group    = EmailGroup.find(params[:email_group_id])
    @digiramp_email.destroy
    redirect_to admin_email_group_path( @email_group )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digiramp_email
      @digiramp_email = DigirampEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def digiramp_email_params
      params.require(:digiramp_email).permit!
    end
end
