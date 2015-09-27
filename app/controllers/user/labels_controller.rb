class User::LabelsController < ApplicationController
  before_action :access_user
  before_action :set_label, only: [:show, :edit, :update, :destroy]
  
  
  def show
    
  end

  def edit
    
  end
  
  def index
    @labels = @user.labels
  end
  
  
  def update
    if @label.update(label_params)
      redirect_to user_user_label_path(@user, @label)
    else
      render :edit
    end
  end
  
  def new
    @label = Label.new
  end
  
  def create
    @label = Label.new(label_params)
  
    respond_to do |format|
      if @label.save
        format.html { redirect_to user_user_label_path(@user, @label), notice: 'Label was successfully created.' }
        format.json { render :show, status: :created, location: @label }
      else
        format.html { render :new }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    
  end
  
  private
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def label_params
      params.require(:label).permit(
        :title, 
        :body, 
        :image, 
        :user_id, 
        :account_id, 
        :default_distribution_agreement_id,
        address_attributes: [  :first_name,
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