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
      params.require(:label).permit(:title, :body, :image, :user_id, :account_id)
    end
end