class Admin::TermsController < ApplicationController
  before_action :admin_only
  before_action :set_admin_term, only: [:show, :edit, :update, :destroy]

  # GET /admin/terms
  # GET /admin/terms.json
  def index
    @admin_terms = Admin::Term.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(32)
    #@admin_terms = Admin::Term.all
  end

  # GET /admin/terms/1
  # GET /admin/terms/1.json
  def show
  end

  # GET /admin/terms/new
  def new
    @admin_term = Admin::Term.new
  end

  # GET /admin/terms/1/edit
  def edit
  end

  # POST /admin/terms
  # POST /admin/terms.json
  def create
    @admin_term = Admin::Term.new(admin_term_params)

    respond_to do |format|
      if @admin_term.save
        format.html { redirect_to admin_terms_path, notice: 'Term was successfully created.' }
        format.json { render :show, status: :created, location: @admin_term }
      else
        format.html { render :new }
        format.json { render json: @admin_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/terms/1
  # PATCH/PUT /admin/terms/1.json
  def update
    respond_to do |format|
      if @admin_term.update(admin_term_params)
        format.html { redirect_to admin_terms_path, notice: 'Term was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_term }
      else
        format.html { render :edit }
        format.json { render json: @admin_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/terms/1
  # DELETE /admin/terms/1.json
  def destroy
    @admin_term.destroy
    respond_to do |format|
      format.html { redirect_to admin_terms_url, notice: 'Term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_term
      @admin_term = Admin::Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_term_params
      params.require(:admin_term).permit(:title, :body)
    end
end
