class Admin::WidgetThemesController < ApplicationController
  before_action :set_widget_theme, only: [:show, :edit, :update, :destroy]
  before_filter :admins_only
  # GET /widget_themes
  # GET /widget_themes.json
  def index
    @widget_themes = WidgetTheme.all
  end

  # GET /widget_themes/1
  # GET /widget_themes/1.json
  def show
  end

  # GET /widget_themes/new
  def new
    @widget_theme = WidgetTheme.new
  end

  # GET /widget_themes/1/edit
  def edit
  end

  # POST /widget_themes
  # POST /widget_themes.json
  def create
    @widget_theme = WidgetTheme.create(widget_theme_params)
    redirect_to admin_widget_themes_path
    
  end

  # PATCH/PUT /widget_themes/1
  # PATCH/PUT /widget_themes/1.json
  def update
    
    @widget_theme.update!(widget_theme_params)
    redirect_to admin_widget_themes_path
       
  end

  # DELETE /widget_themes/1
  # DELETE /widget_themes/1.json
  def destroy
    @widget_theme.destroy
    redirect_to admin_widget_themes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget_theme
      @widget_theme = WidgetTheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_theme_params
      params.require(:widget_theme).permit!
    end
end
