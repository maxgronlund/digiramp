class ErrorsController < ApplicationController
  
  #layout 'error'
 
  # 404
  def not_found
    
    if params[:error_type]
      
      @error_type           = params[:error_type].gsub('user/', '') 
      #if @error_type == 'recording_tags'
      #  @error_type = 'error'
      #end
      @user                 = current_user
      @redirect_to_message  = params[:redirect_to_message] if params[:redirect_to_message]

    end
    render status: :not_found
  end
 
  def unprocessable_entity
    render status: :unprocessable_entity
  end
 
  def server_error
    render status: :server_error
  end
end