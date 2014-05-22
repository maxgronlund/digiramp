class CustomerEventsController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  
  before_action :set_customer_event, only: [:show, :edit, :update, :destroy]

  # GET /customer_events
  # GET /customer_events.json
  def index
    @customer_events = CustomerEvent.all
  end

  # GET /customer_events/1
  # GET /customer_events/1.json
  def show
    
    @account_user     = AccountUser.cached_find(params[:customer_id])
    #@customer_event   = CustomerEvent.cached_find(params[:id])

  end


  def new
    @account_user       = AccountUser.cached_find(params[:customer_id])
    #@customer_event     = CustomerEvent.new
  end


  def edit
    @account_user     = AccountUser.cached_find(params[:customer_id])
    
    #logger.debug '----------------------------------------------------------' 
    #logger.debug @customer_event.action_type
    #logger.debug '----------------------------------------------------------' 
    
    
    
    
  end
  
  def create
    costomer_event                  = CustomerEvent.new
    costomer_event.event_type       = params[:event_type]
    costomer_event.account_id       = params[:account_id]
    costomer_event.account_user_id  = params[:account_user_id]
    costomer_event.save!

    redirect_to edit_account_customer_customer_event_path(
                                                            params[:account_id],
                                                            params[:account_user_id],
                                                            costomer_event.id 
                                                          )
    
  end




  # PATCH/PUT /customer_events/1
  # PATCH/PUT /customer_events/1.json
  def update
    
    @account_user     = AccountUser.cached_find(params[:customer_id])
    
    
    case @customer_event.action_type
      
    when 'compose_invitation_email'
      # avoid building the playlist two times
      params[:customer_event][:action_type]       = 'build_playlist'
      params[:customer_event][:playlist_key_id]   = Playlist.create_playlist_with_key( @account, @customer_event.account_user)

      #here we are adding playlist items to the playlist
       
    end
    
    
    
    @customer_event.update_attributes(customer_event_params)
    #redirect_to edit_account_playlist_path(@account, @customer_event.playlist_key.playlist_id)
    redirect_to account_playlist_playlist_recordings_path(@account, @customer_event.playlist_key.playlist_id)
    
    #redirect_to :back
    
  end

  # DELETE /customer_events/1
  # DELETE /customer_events/1.json
  def destroy
    @account_user     = AccountUser.cached_find(params[:customer_id])
    @customer_event   = CustomerEvent.cached_find(params[:id])
    # how about remove from playlist
    @customer_event.destroy
    redirect_to account_customer_path(@account, @account_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_event
      @customer_event   = CustomerEvent.cached_find(params[:id])
      #@customer_event = CustomerEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_event_params
      params.require(:customer_event).permit!
    end
end
