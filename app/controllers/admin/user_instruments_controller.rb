class Admin::UserInstrumentsController < ApplicationController
  before_action :admin_only
  def index
    @instruments = Instrument.where(user_tag: true).order('lower(title) ASC').page(params[:page]).per(32)
  end
end
