class TermsController < ApplicationController
  def show
    @term = Admin::Term.find(params[:id])
  end
end
