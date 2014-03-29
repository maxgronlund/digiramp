class CustomerEventsController < ApplicationController
  before_filter :there_is_access_to_the_account
  before_action :set_customer_event, only: [:show, :edit, :update, :destroy]

  # GET /customer_events
  # GET /customer_events.json
  def index
    @customer_events = CustomerEvent.all
  end

  # GET /customer_events/1
  # GET /customer_events/1.json
  def show
    
    @account_user     = AccountUser.find_by_cached_id(params[:customer_id])
    @customer_event   = CustomerEvent.cached_find(params[:id])

  end


  def new
    @account_user       = AccountUser.find_by_cached_id(params[:customer_id])
    @customer_event     = CustomerEvent.new
  end


  def edit
  end


  def create
    @account_user     = AccountUser.find_by_cached_id(params[:customer_id])
    @customer_event   = CustomerEvent.create(customer_event_params)
    
    case @customer_event.event_type
      
    when 'Private Playlist'
      # create a playlist
      playlist = Playlist.create(account_id: @account.id,
                                 title: "Playlist for #{@account_user.get_name}")
      # make a PlaylistKey 
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      playlist_key = PlaylistKey.create(playlist_id: playlist.id,
                                        user_id: @account_user.user_id,
                                        account_id: @account.id,
                                        password_protection: true,
                                        password: secret_temp_password,
                                        expires: false,
                                        expiration_date: Date.current()>>1,
                                        page_link: 'google.com'
                                        )
                                        
                                        
      @customer_event.playlist_key_id = playlist_key.id
      @customer_event.save!
      
      # go to the playlist wizard
      # use the key as ID
      # account/id/playlist_wizard/key_id
      redirect_to edit_account_playlist_wizard_path(@account, playlist_key)
    else
      redirect_to account_customer_path(@account, @account_user)
    end
    
  end

  # PATCH/PUT /customer_events/1
  # PATCH/PUT /customer_events/1.json
  def update
    
  end

  # DELETE /customer_events/1
  # DELETE /customer_events/1.json
  def destroy
    @customer_event.destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_event
      @customer_event = CustomerEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_event_params
      params.require(:customer_event).permit!
    end
end
