class VocabularyController < ApplicationController
  def index
    @terms = Admin::Term.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(32)
  end
end
