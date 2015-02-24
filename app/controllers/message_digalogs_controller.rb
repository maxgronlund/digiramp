class MessageDigalogsController < ApplicationController
  def new
    ap params
    @recipient  = User.cached_find(params[:receiver])
    @sender     = User.cached_find(params[:sender])
    @message    = Message.new(title: params[:title], subjebtable_id: params[:subjebtable_id], subjebtable_type: params[:subjebtable_type])
  end

end

