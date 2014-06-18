class DocumentsController < ApplicationController
  include AccountsHelper

  before_filter :access_account
  
  def index
    @documents = @account.attachments.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(16)
  end

  def show
    @attachment = Attachment.find(params[:id])
    #@document   = @attachment.account_file
  end
end
