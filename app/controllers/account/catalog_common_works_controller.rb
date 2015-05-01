class Account::CatalogCommonWorksController < ApplicationController
  #include RecordingsHelper
  include AccountsHelper
  before_action :access_account

  
  def index
    forbidden unless current_account_user.read_recording?
    @catalog        = Catalog.cached_find(params[:catalog_id]).page(params[:page]).per(48)
    @common_works   = @catalog.common_works
  end
end
