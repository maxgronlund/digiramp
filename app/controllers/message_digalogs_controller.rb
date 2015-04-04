class MessageDigalogsController < ApplicationController
  def new
    @recipient                = User.cached_find(params[:receiver])
    @sender                   = User.cached_find(params[:sender])
    @message                  = Message.new(title: params[:title], subjectable_id: params[:subjectable_id], subjectable_type: params[:subjectable_type])
  end

end

