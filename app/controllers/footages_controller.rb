class FootagesController < ApplicationController
  before_action :set_footage, only: [:show, :edit, :update, :destroy]

  # GET /footages
  # GET /footages.json
  def index
    @footages = Footage.all
  end

  # GET /footages/1
  # GET /footages/1.json
  def show
  end

  # GET /footages/new
  def new
    @footage = Footage.new
  end

  # GET /footages/1/edit
  def edit
  end

  # POST /footages
  # POST /footages.json
  def create
    @footage = Footage.new(footage_params)

    respond_to do |format|
      if @footage.save
        format.html { redirect_to @footage, notice: 'Footage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @footage }
      else
        format.html { render action: 'new' }
        format.json { render json: @footage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /footages/1
  # PATCH/PUT /footages/1.json
  def update
    respond_to do |format|
      if @footage.update(footage_params)
        format.html { redirect_to @footage, notice: 'Footage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @footage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /footages/1
  # DELETE /footages/1.json
  def destroy
    @footage.destroy
    respond_to do |format|
      format.html { redirect_to footages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_footage
      @footage = Footage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def footage_params
      params.require(:footage).permit(:title, :body, :transloadet, :thumb, :uuid, :mp4_file, :webm_file, :copyright, :footagable_type, :footageable_id)
    end
end
