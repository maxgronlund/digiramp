class User::PublishingAgreementsController < ApplicationController
  before_action :set_publishing_agreement, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  # GET /publishing_agreements
  # GET /publishing_agreements.json
  def index
    @publisher            = Publisher.cached_find(params[:publisher_id])
    @publishing_agreements = @publisher.publishing_agreements
  end

  # GET /publishing_agreements/1
  # GET /publishing_agreements/1.json
  def show
    @publisher            = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement = PublishingAgreement.cached_find(params[:id])
  end

  # GET /publishing_agreements/new
  def new
    if params[:document_uuid]
      @document = Document.cached_find(params[:document_uuid])
    else
      @documents            = @user.account.documents#.where(tag: 'Recording', document_type: 'Legal')
    end
    
    @publisher            = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement = PublishingAgreement.new
    
  end

  # GET /publishing_agreements/1/edit
  def edit
    @publisher             = Publisher.cached_find(params[:publisher_id])
    
    #@documents             = @user.account.documents#.where(tag: 'Recording', document_type: 'Legal')
    @publishing_agreement   = PublishingAgreement.cached_find(params[:id])
    #@documents              = @publishing_agreement.document
  end

  # POST /publishing_agreements
  # POST /publishing_agreements.json
  def create

    @publisher            = Publisher.cached_find(params[:publisher_id])
    params[:publishing_agreement][:uuid] = UUIDTools::UUID.timestamp_create().to_s
    @publishing_agreement  = PublishingAgreement.new(publishing_agreement_params)
     
    respond_to do |format|
      if @publishing_agreement.save
        format.html { redirect_to user_user_publisher_publishing_agreements_path( @user, @publisher), info: 'Publishing deal was successfully created.' }
        format.json { render :show, status: :created, location: @publishing_agreement }
      else
        format.html { render :new }
        format.json { render json: @publishing_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publishing_agreements/1
  # PATCH/PUT /publishing_agreements/1.json
  def update
    
    @publisher              = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement   = PublishingAgreement.cached_find(params[:id])

    
    if @publishing_agreement.update(publishing_agreement_params)
      redirect_to user_user_publisher_publishing_agreements_path( @user, @publisher)
    else
      flash[:danger] = "Something went wrong" 
      render :edit
    end
    
    #respond_to do |format|
    #  if @publishing_agreement.update(publishing_agreement_params)
    #    format.html { redirect_to user_user_publisher_publishing_agreement_path(@user, @publishing_agreement.publisher, @publishing_agreement), notice: 'Publishing deal was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @publishing_agreement }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @publishing_agreement.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /publishing_agreements/1
  # DELETE /publishing_agreements/1.json
  def destroy
    @publisher              = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement.destroy
    respond_to do |format|
      format.html { redirect_to user_user_publisher_path(@user, @publisher), notice: 'Publishing deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publishing_agreement
      @publishing_agreement = PublishingAgreement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publishing_agreement_params
      params.require(:publishing_agreement).permit!
    end
end
