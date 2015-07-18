class User::RecordingUsersController < ApplicationController
  before_action :set_recording_user, only: [:show, :edit, :update, :destroy]

  # GET /recording_users
  # GET /recording_users.json
  def index
    @recording_users = RecordingUser.all
  end

  # GET /recording_users/1
  # GET /recording_users/1.json
  def show
  end

  # GET /recording_users/new
  def new
    @recording_user = RecordingUser.new
  end

  # GET /recording_users/1/edit
  def edit
  end

  # POST /recording_users
  # POST /recording_users.json
  def create
    @recording_user = RecordingUser.new(recording_user_params)

    respond_to do |format|
      if @recording_user.save
        format.html { redirect_to @recording_user, notice: 'Recording user was successfully created.' }
        format.json { render :show, status: :created, location: @recording_user }
      else
        format.html { render :new }
        format.json { render json: @recording_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recording_users/1
  # PATCH/PUT /recording_users/1.json
  def update
    respond_to do |format|
      if @recording_user.update(recording_user_params)
        format.html { redirect_to @recording_user, notice: 'Recording user was successfully updated.' }
        format.json { render :show, status: :ok, location: @recording_user }
      else
        format.html { render :edit }
        format.json { render json: @recording_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recording_users/1
  # DELETE /recording_users/1.json
  def destroy
    @recording_user.destroy
    respond_to do |format|
      format.html { redirect_to recording_users_url, notice: 'Recording user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording_user
      @recording_user = RecordingUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recording_user_params
      params.require(:recording_user).permit(:user_id, :recording_id, :email)
    end
end
