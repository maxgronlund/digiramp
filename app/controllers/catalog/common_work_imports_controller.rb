class Catalog::CommonWorkImportsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
                                       
                                       
  def new
  end

  def select_pro
  end

  def from_ascap
  end

  def from_bmi
  end

  def show
  end
end
