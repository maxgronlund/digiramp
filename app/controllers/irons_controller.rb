class IronsController < ApplicationController
  before_action :set_iron, only: [:show, :edit, :update, :destroy]

  # GET /irons
  # GET /irons.json
  def index
    @irons = Iron.all
  end

  # GET /irons/1
  # GET /irons/1.json
  def show
    # params
    
    render nothing: true
  end

  # GET /irons/new
  def new
    @iron = Iron.new
  end

  # GET /irons/1/edit
  def edit
  end

  # POST /irons
  # POST /irons.json
  def create
    # params
    
    render nothing: true
    #@iron = Iron.new(iron_params)
    #
    #respond_to do |format|
    #  if @iron.save
    #    format.html { redirect_to @iron, notice: 'Iron was successfully created.' }
    #    format.json { render :show, status: :created, location: @iron }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @iron.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /irons/1
  # PATCH/PUT /irons/1.json
  def update
    respond_to do |format|
      if @iron.update(iron_params)
        format.html { redirect_to @iron, notice: 'Iron was successfully updated.' }
        format.json { render :show, status: :ok, location: @iron }
      else
        format.html { render :edit }
        format.json { render json: @iron.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /irons/1
  # DELETE /irons/1.json
  def destroy
    @iron.destroy
    respond_to do |format|
      format.html { redirect_to irons_url, notice: 'Iron was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iron
      @iron = Iron.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iron_params
      params.require(:iron).permit(:title)
    end
end
