class ErrorsController < ActionController::Base
  #layout 'error'
 
  # 404
  def not_found
    ap '================= errors/not_found ========================'
    ap params
    render status: :not_found
  end
 
  def unprocessable_entity
    render status: :unprocessable_entity
  end
 
  def server_error
    render status: :server_error
  end
end