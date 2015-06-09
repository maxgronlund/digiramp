class User::PlaylistEmailsController < ApplicationController
  before_action :set_playlist_email, only: [:show, :edit, :update, :destroy]
  before_action :access_user


  # GET /playlist_emails/1
  # GET /playlist_emails/1.json
  def show
    @playlist        = Playlist.cached_find( params[:playlist_id ])
  end

  # GET /playlist_emails/new
  def new
    @playlist        = Playlist.cached_find( params[:playlist_id ])
    @playlist_emails = @playlist.playlist_emails
    @playlist_email  = PlaylistEmail.new
  end

  # POST /playlist_emails
  # POST /playlist_emails.json
  def create
    @playlist_email  = PlaylistEmail.new(playlist_email_params)
    @playlist        = Playlist.cached_find( params[:playlist_id ])
    @playlist_emails = @playlist.playlist_emails
    
    respond_to do |format|
      if @playlist_email.save
        format.html { redirect_to new_user_user_playlist_playlist_email_path(@user, @playlist), notice: 'Playlist email was successfully created.' }
        format.json { render :show, status: :created, location: @playlist_email }
      else
        format.html { render :new }
        format.json { render json: @playlist_email.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist_email
      @playlist_email = PlaylistEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_email_params
      params.require(:playlist_email).permit(:email_list, :title, :body, :attach_files, :playlist_id, :user_id, :account_id)
    end
end
