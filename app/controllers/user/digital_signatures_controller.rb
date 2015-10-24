class User::DigitalSignaturesController < ApplicationController
  before_action :set_digital_signature, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  # GET /digital_signatures
  # GET /digital_signatures.json
  def index
    @digital_signatures = @user.digital_signatures.where(hidden: false)
    @selected_digital_signature = @user.digital_signature
  end
  
  def show
   
    @user.update(digital_signature_uuid: @digital_signature.uuid) 
    redirect_to :back
  end

  # GET /digital_signatures/new
  def new
    @digital_signature = DigitalSignature.new
  end
  
  def update

    #@digital_signature = DigitalSignature.cached_find(params[:id])
    @digital_signature.email = params[:digital_signature][:email]
    @digital_signature.role  = params[:digital_signature][:role]
    if user = User.find_by(email: @digital_signature.email)
      @digital_signature.user_id = user.id
    end
    @digital_signature.save validate: false         #.update!(digital_signature_params)
    
  end


  # POST /digital_signatures
  # POST /digital_signatures.json
  def create
    params[:digital_signature][:uuid] = UUIDTools::UUID.timestamp_create().to_s
    @digital_signature = DigitalSignature.new(digital_signature_params)


    if @digital_signature.save
      unless @user.digital_signature
        @user.update(digital_signature_uuid: @digital_signature.uuid) 
      end
      redirect_to_special_url( user_user_digital_signatures_path(@user) ) 
    else
      render :new 
    end

  end

  # DELETE /digital_signatures/1
  # DELETE /digital_signatures/1.json
  def destroy
    @digital_signature.hidden = true
    @digital_signature.save
    
    ap @user.digital_signature_uuid
    ap @digital_signature.uuid
    if @user.digital_signature_uuid == @digital_signature.uuid
      @user.update(digital_signature_uuid: nil) 
    end
    ap @user.digital_signature_uuid
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
      params.require(:digital_signature).permit(:uuid, :user_id, :image, :email, :role)
    end
end
