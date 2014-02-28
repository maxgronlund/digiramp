class HomeController < ApplicationController

  def index
    @home = Home.front
  end
end
