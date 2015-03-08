class Account::AttachmentsController < ApplicationController


  def destroy 
    go_to = params[:return_url]
    attachment = Attachment.cached_find(params[:id])
    attachment.destroy

    redirect_to go_to

  end

  
end
