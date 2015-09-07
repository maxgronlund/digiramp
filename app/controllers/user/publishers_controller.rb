class User::PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  # GET /publishers
  # GET /publishers.json
  def index
    @publishers = @user.publishers
   
  end

  # GET /publishers/1
  # GET /publishers/1.json
  def show
  end

  # GET /publishers/new
  def new
    @publisher = Publisher.new
  end

  # GET /publishers/1/edit
  def edit
  end

  # POST /publishers
  # POST /publishers.json
  def create
    
    
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        
        if @publisher.i_am_my_own_publisher
          @user.copy_address_to( @publisher.address ) 
          format.html { redirect_to edit_user_user_publisher_legal_info_path(@publisher.user, @publisher), info: 'Please add legal informations.' }
        else
          
          @publisher.check_ownership!
          format.html { redirect_to user_user_publisher_path(@publisher.user, @publisher) }
        end
        format.json { render :show, status: :created, location: @publisher }
      else
        format.html { render :new }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publishers/1
  # PATCH/PUT /publishers/1.json
  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        @publisher.check_ownership! 
        @publisher.add_user_email!
        format.html { redirect_to user_user_publisher_path(@publisher.user, @publisher) }
        format.json { render :show, status: :ok, location: @publisher }
      else
        format.html { render :edit }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publishers/1
  # DELETE /publishers/1.json
  def destroy
    @publisher.destroy
    respond_to do |format|
      format.html { redirect_to user_user_publishers_path(@user), ibfo: 'Publisher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:account_id, 
                                        :user_id,
                                        :legal_name,
                                        :email, 
                                        :phone_number, 
                                        :ipi_code, 
                                        :cae_code, 
                                        :uuid, 
                                        :pro_affiliation_id, 
                                        :status,
                                        :i_am_my_own_publisher,
                                        :show_on_public_page,
                                        :description,
                                        address_attributes: 
                                        [
                                           :first_name,
                                           :middle_name,
                                           :last_name,
                                           :address_line_1,
                                           :address_line_2,
                                           :city,
                                           :state,
                                           :country,
                                           :id,
                                           :zip_code
                                         ]
                                        )
    end
end
