class MessagesController < ApplicationController
  
  before_filter :access_user, only: [ :show, :index, :create, :destroy]

  def new
  end

  def index
    @authorized = true 
    #@messages = Message.order(created_at: :desc).where("recipient_id = ? OR sender_id = ? AND recipient_removed = ?" , @user.id, @user.id, false)
    
    
    #send_message_ids     = Message.last(200).where(sender_id: @user.id, sender_removed: false).pluck(:id)
    #received_message_ids = Message.last(200).where(sender_id: @user.id, sender_removed: false).pluck(:id)
    #message_ids = send_message_ids + received_message_ids
    #@messages = Message.where(id: message_ids)
    
    
    #@messages = Message.order(created_at: :desc).where("recipient_id = ? OR sender_id = ?" , @user.id, @user.id)
    
    @messages = Message.order(created_at: :desc).where("recipient_id = ? AND recipient_removed = ? OR sender_id = ? AND sender_removed = ?" , @user.id, false,  @user.id, false)

  end
  
  def show
    @message = Message.cached_find(params[:id])
  end

  def create
    message = Message.create(message_params)
    
    
    receiver = User.cached_find(message.recipient_id)
    sender   = User.cached_find(message.sender_id)
    
    
    channel = 'digiramp_radio_' + receiver.email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'Message received', 
                                          "message" => "#{sender.user_name} has send you a message", 
                                          "time"    => '5000', 
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
    
    ap @message
    @message.save
    
    
  end
  
private  
  def message_params
    params.require(:message).permit!
  end
end
