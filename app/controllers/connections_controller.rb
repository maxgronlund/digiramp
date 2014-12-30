class ConnectionsController < ApplicationController
  before_action :set_connection, only: [:edit, :update, :destroy]

  before_filter :access_user, only: [:index]
  

  def index
    #@connections = @user.connections
    
    @connections = Connection.where("user_id = ?  OR  connection_id = ?" , @user.id, @user.id)
    @authorized  = @user.id == current_user.id
  end

  


  def create
    @connection       = Connection.create(connection_params)
    @user             = User.cached_find(@connection.connection_id)
    send_invitation
  end
  
  def update
    ap params
    if params[:commit] == "Dismiss" || params[:commit] == "Disconnect"
      params[:connection][:dismissed] = true
      params[:connection][:approved] = false
    else
      params[:connection][:dismissed] = false
      
    end
    @connection.update_attributes(connection_params)
    @receiver = User.find(@connection.connection_id) if User.exists?(@connection.connection_id)
    
    notify_requester
  end
  
  

  

  # DELETE /connections/1
  # DELETE /connections/1.json
  def destroy
    @connection_id = @connection.id
    @connection.destroy
  end
  
  def self.connected user_1, user_2
    connection = Connection.where(user_id: user_1.id,  connection_id: user_2.id).first 
    connection = Connection.where(user_id: user_2.id,  connection_id: user_1.id).first unless connection
    return false if connection.dismissed
    connection.approved
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection
      @connection = Connection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_params
      params.require(:connection).permit(:user_id, :connection_id, :approved, :dismissed, :message)
    end
    
    
    def notify_requester
      @receiver = User.cached_find(@connection.user_id)
      sender    = User.cached_find(@connection.connection_id)
      
      
      @message                    = Message.new
      @message.recipient_id       = @receiver.id
      @message.sender_id          = sender.id
      @message.title              = sender.user_name + ' has evaluated your request '
      @message.body               = sender.user_name + ' has updated the status on your request to ' + @connection.status 
      @message.subjebtable_id     = @connection.id
      @message.subjebtable_type   = 'Connection'
      @message.save
    
    
      channel = 'digiramp_radio_' + @receiver.email
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Message received', 
                                            "message" => "#{sender.user_name} has evaluated your request", 
                                            "time"    => '2500', 
                                            "sticky"  => 'false', 
                                            "image"   => 'notice'
                                            })
      
    
    end
    
    def send_invitation

      
      @receiver = User.cached_find(@connection.connection_id)
      sender    = User.cached_find(@connection.user_id)
      
      
      @message                    = Message.new
      @message.recipient_id       = @receiver.id
      @message.sender_id          = sender.id
      @message.title              = sender.user_name + ' wants to connect with you'
      @message.body               = @connection.message
      @message.subjebtable_id     = @connection.id
      @message.subjebtable_type   = 'Connection'
      @message.save
    
    
      channel = 'digiramp_radio_' + @receiver.email
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Message received', 
                                            "message" => "#{sender.user_name} has send you an invitation", 
                                            "time"    => '3000', 
                                            "sticky"  => 'false', 
                                            "image"   => 'notice'
                                            })
      
      
      
      
      
    end
end



#  t.integer  "recipient_id"
#  t.integer  "sender_id"
#  t.string   "title"
#  t.text     "body"
#  t.integer  "subjebtable_id"
#  t.string   "subjebtable_type"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.boolean  "sender_removed",    default: false
#  t.boolean  "recipient_removed", default: false
#  t.boolean  "read",              default: false
