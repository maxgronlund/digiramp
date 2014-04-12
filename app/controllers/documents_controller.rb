class DocumentsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @documents = @account.attachments.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(16)
  end

  def show
    @attachment = Attachment.find(params[:id])
    #@document   = @attachment.account_file
  end
end
