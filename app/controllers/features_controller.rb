class FeaturesController < ApplicationController
  def index
    @feature = Feature.front
  end
end
