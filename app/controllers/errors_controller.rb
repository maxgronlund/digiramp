class ErrorsController < ApplicationController
  #layout 'error'
 
  # 404
  def not_found
    ap '================= errors/not_found ========================'
    ap params
    if params[:error_type]
      
      @error_type           = params[:error_type] 
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