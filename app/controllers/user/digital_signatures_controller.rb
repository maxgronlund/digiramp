class User::DigitalSignaturesController < ApplicationController
  before_action :set_digital_signature, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  # GET /digital_signatures
  # GET /digital_signatures.json
  def index
    @digital_signatures = @user.digital_signatures.where(hidden: false)
  end


  # GET /digital_signatures/new
  def new
    @digital_signature = DigitalSignature.new
  end


  # POST /digital_signatures
  # POST /digital_signatures.json
  def create
    @digital_signature = DigitalSignature.new(digital_signature_params)

    respond_to do |format|
      if @digital_signature.save
        format.html { redirect_to user_user_digital_signatures_path(@user), notice: 'Digital signature was successfully created.' }
        format.json { render :show, status: :created, location: @digital_signature }
      else
        format.html { render :new }
        format.json { render json: @digital_signature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digital_signatures/1
  # DELETE /digital_signatures/1.json
  def destroy
    @digital_signature.hidden = true
    @digital_signature.save
    respond_to do |format|
      format.html { redirect_to user_user_digital_signatures_path(@user) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digital_signature
      @digital_signature = DigitalSignature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def digital_signature_params
      params.require(:digital_signature).permit(:uuid, :user_id, :image)
    end
end
