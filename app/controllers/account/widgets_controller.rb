class Account::WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_action :access_account

  # GET /widgets
  # GET /widgets.json
  def index

  end

  # GET /widgets/1
  # GET /widgets/1.json
  def show
    if Rails.env == 'development'
      @snippet = "<iframe width='#{@widget.width}' height='#{@widget.height}' src=\"http://localhost:3000/embed/#{@widget.secret_key}\" frameborder='0' allowfullscreen></iframe>"
    else
      @snippet = "<iframe width='#{@widget.width}' height='#{@widget.height}' src=\"http://digiramp.com/embed/#{@widget.secret_key}\" frameborder='0' allowfullscreen></iframe>"
    end

  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
  end

  # POST /widgets
  # POST /widgets.json
  def create
    params[:widget][:secret_key] = UUIDTools::UUID.timestamp_create().to_s
    @widget = Widget.create(widget_params)
    redirect_to account_account_widget_path( @account, @widget)
    #respond_to do |format|
    #  if @widget.save
    #    format.html { redirect_to @widget, notice: 'Widget was successfully created.' }
    #    format.json { render :show, status: :created, location: @widget }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @widget.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /widgets/1
  # PATCH/PUT /widgets/1.json
  def update
    @widget.update(widget_params)
    
    redirect_to account_account_widget_path( @account, @widget)
    #respond_to do |format|
    #  if @widget.update(widget_params)
    #    format.html { redirect_to @widget, notice: 'Widget was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @widget }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @widget.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
  def destroy
    @widget.destroy
    #respond_to do |format|
    #  format.html { redirect_to widgets_url, notice: 'Widget was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_params
      params.require(:widget).permit!
    end
end
