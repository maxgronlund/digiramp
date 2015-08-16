class User::PublisherLegalInfosController < ApplicationController
  before_action :access_user
  def edit
    @publisher = Publisher.cached_find(params[:id])
  end
end
