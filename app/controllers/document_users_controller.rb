class DocumentUsersController < ApplicationController
  before_action :set_document_user, only: [:show, :edit, :update, :destroy]

  # GET /document_users
  # GET /document_users.json
  def index
    @document_users = DocumentUser.all
  end

  # GET /document_users/1
  # GET /document_users/1.json
  def show
  end

  # GET /document_users/new
  def new
    @document_user = DocumentUser.new
  end

  # GET /document_users/1/edit
  def edit
  end

  # POST /document_users
  # POST /document_users.json
  def create
    @document_user = DocumentUser.new(document_user_params)

    respond_to do |format|
      if @document_user.save
        format.html { redirect_to @document_user, notice: 'Document user was successfully created.' }
        format.json { render :show, status: :created, location: @document_user }
      else
        format.html { render :new }
        format.json { render json: @document_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_users/1
  # PATCH/PUT /document_users/1.json
  def update
    respond_to do |format|
      if @document_user.update(document_user_params)
        format.html { redirect_to @document_user, notice: 'Document user was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_user }
      else
        format.html { render :edit }
        format.json { render json: @document_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_users/1
  # DELETE /document_users/1.json
  def destroy
    @document_user.destroy
    respond_to do |format|
      format.html { redirect_to document_users_url, notice: 'Document user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_user
      @document_user = DocumentUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_user_params
      params.require(:document_user).permit(:document_id, :user_id, :account_id, :can_edit, :should_sign, :email, :signature, :signature_image, :status)
    end
end
