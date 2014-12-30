class MessagesController < ApplicationController
  
  before_filter :access_user, only: [ :show, :index, :create, :destroy]

  def new
  end

  def index
    
    
    @authorized = true 

    if params[:connection_id]
      connection = Connection.cached_find(params[:connection_id])
      @messages = connection.messages.order(created_at: :desc)
    else
      @messages = Message.user_messages(@user)
    end

  end
  
  def show
    @message = Message.cached_find(params[:id])
    @message.read = true
    #@user.messages_not_read = self.received_massages.where(read: false).count
    #@user.save
    @message.save validate: false
    ap @message
    #@authorized   = true
  end

  def create

    @message = Message.create(message_params)


    
    @receiver = User.cached_find(@message.recipient_id)
    sender    = User.cached_find(@message.sender_id)
    
    
    channel = 'digiramp_radio_' + @receiver.email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'Message received', 
                                          "message" => "#{sender.user_name} has send you a message", 
                                          "time"    => '2000', 
                                          "sticky"  => 'false', 
                                          "image"   => 'notice'
                                          })
                                          
                                          
                                          
  end
  
  # prevent hacking
  # and only remove from users account
  def destroy
    @message = Message.cached_find(params[:id])
    # remove messages send and resived by owner
    if @message.recipient_id == @user.id && @message.sender_id == @user.id
      @message.recipient_removed  = true
      @message.sender_removed     = true
    end
    
    # remove messages user has send
    if @message.sender_id == @user.id
      @message.sender_removed = true
    else
      @message.recipient_removed = true
    end
    @message.read = true
    @message.save
    Connection.decrease_messages_count( @message )


  end
  
private  
  def message_params
    params.require(:message).permit!
  end
end
