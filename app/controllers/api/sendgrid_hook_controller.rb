class Api::SendgridHookController < ApplicationController
  protect_from_forgery except: [:update]
  def update
    Rails.logger.info request.content_type
    params.each do |p|
      Rails.logger.info '----------------------------------------------------------------'
      Rails.logger.info p
    end
  end
end
