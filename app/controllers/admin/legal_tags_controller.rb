class Admin::LegalTagsController < ApplicationController
  before_action :set_admin_legal_tag, only: [:show, :edit, :update, :destroy]
  before_action :admins_only
  # GET /admin/legal_tags
  # GET /admin/legal_tags.json
  def index
    @admin_legal_tags = Admin::LegalTag.all
  end

  # GET /admin/legal_tags/1
  # GET /admin/legal_tags/1.json
  def show
  end

  # GET /admin/legal_tags/new
  def new
    @admin_legal_tag = Admin::LegalTag.new
  end

  # GET /admin/legal_tags/1/edit
  def edit
  end

  # POST /admin/legal_tags
  # POST /admin/legal_tags.json
  def create
    @admin_legal_tag = Admin::LegalTag.new(admin_legal_tag_params)

    respond_to do |format|
      if @admin_legal_tag.save
        format.html { redirect_to admin_legal_tags_path, notice: 'Legal tag was successfully created.' }
        format.json { render :show, status: :created, location: @admin_legal_tag }
      else
        format.html { render :new }
        format.json { render json: @admin_legal_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/legal_tags/1
  # PATCH/PUT /admin/legal_tags/1.json
  def update
    respond_to do |format|
      if @admin_legal_tag.update(admin_legal_tag_params)
        format.html { redirect_to admin_legal_tags_path, notice: 'Legal tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_legal_tag }
      else
        format.html { render :edit }
        format.json { render json: @admin_legal_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/legal_tags/1
  # DELETE /admin/legal_tags/1.json
  def destroy
    @admin_legal_tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_legal_tags_url, notice: 'Legal tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_legal_tag
      @admin_legal_tag = Admin::LegalTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_legal_tag_params
      params.require(:admin_legal_tag).permit(:title, :body)
    end
end
