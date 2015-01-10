class TwitterCardsController < ApplicationController
  def index
    @recording = Recording.find(1355)
  end

  def show
  end
end
