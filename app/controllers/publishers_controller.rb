class PublishersController < ApplicationController
  def index
    @publishers = Publisher.wher(show_on_public_page: true)
  end
end
