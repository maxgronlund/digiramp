class User::ProfessionalInfosController < ApplicationController
  before_action :set_professional_info, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  # GET /professional_infos
  # GET /professional_infos.json
  def index
    #@professional_infos = ProfessionalInfo.all
    @professional_info = @user.professional_info
  end

  # GET /professional_infos/1
  # GET /professional_infos/1.json
  def show
  end

  # GET /professional_infos/new
  def new
    @professional_info = ProfessionalInfo.new
  end

  # GET /professional_infos/1/edit
  def edit
  end

  # POST /professional_infos
  # POST /professional_infos.json
  #def create
  #  @professional_info = ProfessionalInfo.new(professional_info_params)
  #
  #  respond_to do |format|
  #    if @professional_info.save
  #      format.html { redirect_to user_user_professional_infos_path @user, notice: 'Professional info was successfully created.' }
  #      format.json { render :show, status: :created, location: @professional_info }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @professional_info.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /professional_infos/1
  # PATCH/PUT /professional_infos/1.json
  def update
    ap params
    respond_to do |format|
      if @professional_info.update(professional_info_params)
        format.html { redirect_to user_user_professional_infos_path @user, notice: 'Professional info was successfully updated.' }
        format.json { render :show, status: :ok, location: @professional_info }
      else
        format.html { render :edit }
        format.json { render json: @professional_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professional_infos/1
  # DELETE /professional_infos/1.json
  def destroy
    @professional_info.destroy
    respond_to do |format|
      format.html { redirect_to professional_infos_url, notice: 'Professional info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional_info
      @professional_info = ProfessionalInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professional_info_params
      params.require(:professional_info).permit(:ipi_code, :alias, address_attributes: [
                                                                      :first_name,
                                                                      :middle_name,
                                                                      :last_name,
                                                                      :address_line_1,
                                                                      :address_line_2,
                                                                      :city,
                                                                      :state,
                                                                      :country,
                                                                      :id,
                                                                      :zip_code]
                                              )
    end
        
end
