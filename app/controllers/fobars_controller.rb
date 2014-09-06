class FobarsController < ApplicationController
  before_action :set_fobar, only: [:show, :edit, :update, :destroy]

  # GET /fobars
  # GET /fobars.json
  def index
    @fobars = Fobar.all
  end

  # GET /fobars/1
  # GET /fobars/1.json
  def show
  end

  # GET /fobars/new
  def new
    @fobar = Fobar.new
  end

  # GET /fobars/1/edit
  def edit
  end

  # POST /fobars
  # POST /fobars.json
  def create
    @fobar = Fobar.new(fobar_params)

    respond_to do |format|
      if @fobar.save
        format.html { redirect_to @fobar, notice: 'Fobar was successfully created.' }
        format.json { render :show, status: :created, location: @fobar }
      else
        format.html { render :new }
        format.json { render json: @fobar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fobars/1
  # PATCH/PUT /fobars/1.json
  def update
    respond_to do |format|
      if @fobar.update(fobar_params)
        format.html { redirect_to @fobar, notice: 'Fobar was successfully updated.' }
        format.json { render :show, status: :ok, location: @fobar }
      else
        format.html { render :edit }
        format.json { render json: @fobar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fobars/1
  # DELETE /fobars/1.json
  def destroy
    @fobar.destroy
    respond_to do |format|
      format.html { redirect_to fobars_url, notice: 'Fobar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fobar
      @fobar = Fobar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fobar_params
      params.require(:fobar).permit(:index)
    end
end
