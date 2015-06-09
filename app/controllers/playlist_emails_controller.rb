class PlaylistEmailsController < ApplicationController
  before_action :set_playlist_email, only: [:show, :edit, :update, :destroy]

  # GET /playlist_emails
  # GET /playlist_emails.json
  def index
    @playlist_emails = PlaylistEmail.all
  end

  # GET /playlist_emails/1
  # GET /playlist_emails/1.json
  def show
  end

  # GET /playlist_emails/new
  def new
    @playlist_email = PlaylistEmail.new
  end

  # GET /playlist_emails/1/edit
  def edit
  end

  # POST /playlist_emails
  # POST /playlist_emails.json
  def create
    @playlist_email = PlaylistEmail.new(playlist_email_params)
  
    respond_to do |format|
      if @playlist_email.save
        format.html { redirect_to @playlist_email, notice: 'Playlist email was successfully created.' }
        format.json { render :show, status: :created, location: @playlist_email }
      else
        format.html { render :new }
        format.json { render json: @playlist_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlist_emails/1
  # PATCH/PUT /playlist_emails/1.json
  def update
    respond_to do |format|
      if @playlist_email.update(playlist_email_params)
        format.html { redirect_to @playlist_email, notice: 'Playlist email was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist_email }
      else
        format.html { render :edit }
        format.json { render json: @playlist_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlist_emails/1
  # DELETE /playlist_emails/1.json
  def destroy
    @playlist_email.destroy
    respond_to do |format|
      format.html { redirect_to playlist_emails_url, notice: 'Playlist email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist_email
      @playlist_email = PlaylistEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_email_params
      params.require(:playlist_email).permit(:emails, :title, :body, :attach_files, :playlist_id, :user_id, :account_id)
    end
end
