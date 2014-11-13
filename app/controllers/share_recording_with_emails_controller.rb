class ShareRecordingWithEmailsController < ApplicationController
  before_action :set_share_recording_with_email, only: [:show, :edit, :update, :destroy]

  # GET /share_recording_with_emails
  # GET /share_recording_with_emails.json
  #def index
  #  @share_recording_with_emails = ShareRecordingWithEmail.all
  #end
  #
  ## GET /share_recording_with_emails/1
  ## GET /share_recording_with_emails/1.json
  #def show
  #end
  #
  ## GET /share_recording_with_emails/new
  #def new
  #  @share_recording_with_email = ShareRecordingWithEmail.new
  #end

  # GET /share_recording_with_emails/1/edit
  def edit
  end

  # POST /share_recording_with_emails
  # POST /share_recording_with_emails.json
  def create
    ap params
    
    
    
    @share_recording_with_email = ShareRecordingWithEmail.create(share_recording_with_email_params)
    


    @share_recording_with_email.recipients.split(',').each do |email|
      if EmailValidator.validate( email )
        ShareRecordingWithEmailMailer.delay.send_email( @share_recording_with_email.id, email )                         
      end
    end
    
    sender = User.cached_find(params[:share_recording_with_email][:user_id])
    channel = 'digiramp_radio_' + sender.email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'RECORDING SHARED', 
                                          "message" => "An email is send", 
                                          "time"    => '15000', 
                                          "sticky"  => 'false', 
                                          "image"   => 'notice'
                                          })
                                          
                                          

    #respond_to do |format|
    #  if @share_recording_with_email.save
    #    format.html { redirect_to @share_recording_with_email, notice: 'Share recording with email was successfully created.' }
    #    format.json { render :show, status: :created, location: @share_recording_with_email }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @share_recording_with_email.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /share_recording_with_emails/1
  # PATCH/PUT /share_recording_with_emails/1.json
  def update
    respond_to do |format|
      if @share_recording_with_email.update(share_recording_with_email_params)
        format.html { redirect_to @share_recording_with_email, notice: 'Share recording with email was successfully updated.' }
        format.json { render :show, status: :ok, location: @share_recording_with_email }
      else
        format.html { render :edit }
        format.json { render json: @share_recording_with_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /share_recording_with_emails/1
  # DELETE /share_recording_with_emails/1.json
  #def destroy
  #  @share_recording_with_email.destroy
  #  respond_to do |format|
  #    format.html { redirect_to share_recording_with_emails_url, notice: 'Share recording with email was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_recording_with_email
      @share_recording_with_email = ShareRecordingWithEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_recording_with_email_params
      params.require(:share_recording_with_email).permit(:user_id, :recording_id, :recipients, :title, :message)
    end
end
