class Account::AccountsController < ApplicationController
  
  include AccountsHelper
  before_filter :access_account
  #before_filter :access_user, only: [:edit, :show]
  
  
  def show

    # repairs an old corupted account
    unless current_account_user
      @account.initialize_account_owner 
      @account.initialize_super_users
      @account.save!
      flash[:info]      = { title: "FYI", body: "User Permissions updated" }
    end

    
    session[:account_id]  = @account.id

  end
  
  def edit
    @account = Account.cached_find(params[:id])
    @user = @account.user
  end
  
  def update
    @account  = Account.cached_find(params[:id])
    @account.update_attributes(account_params)

    redirect_to account_account_path(  @account)

  end
  
  def account_params
    params.require(:account).permit!
  end
  
  def find_recording_in_bucket
    
  end
  
  def recordings
    
  end
  
  def legal_documents
    forbidden unless current_account_user.read_legal_document?
    @files = @account.documents.legal
  end
  
  def financial_documents
    forbidden unless current_account_user.read_financial_document?
    @files = @account.documents.financial
  end
  
  def artwork
    
  end
  
  def files
    @files = @account.documents.files
  end


end
