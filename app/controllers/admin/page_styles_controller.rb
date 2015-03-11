class Admin::PageStylesController < ApplicationController
  before_action :set_page_style, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only
  # GET /page_styles
  # GET /page_styles.json
  def index
    @page_styles = PageStyle.all
  end

  # GET /page_styles/1
  # GET /page_styles/1.json
  def show
  end

  # GET /page_styles/new
  def new
    @page_style = PageStyle.new
  end

  # GET /page_styles/1/edit
  def edit
  end

  # POST /page_styles
  # POST /page_styles.json
  def create
    if @page_style = PageStyle.create(page_style_params)
      redirect_to admin_page_styles_path
    else
      redirect_to new_admin_page_style_path
    end
    
  end

  # PATCH/PUT /page_styles/1
  # PATCH/PUT /page_styles/1.json
  def update
    
    if @page_style.update(page_style_params)
      redirect_to admin_page_styles_path
    else
      redirect_to edit_admin_page_style_path( @page_style )
    end
    
    
    
    #respond_to do |format|
    #  if @page_style.update(page_style_params)
    #    format.html { redirect_to @page_style, notice: 'Page style was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @page_style }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @page_style.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /page_styles/1
  # DELETE /page_styles/1.json
  def destroy
    @page_style.destroy
    respond_to do |format|
      format.html { redirect_to admin_page_styles_url, notice: 'Page style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_style
      @page_style = PageStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_style_params
      params.require(:page_style).permit!
    end
end
