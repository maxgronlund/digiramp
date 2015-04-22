class SnsMessagesController < ApplicationController
  
  protect_from_forgery only: :receive
  def receive
    ap params
    render nothing: true
  end
end
