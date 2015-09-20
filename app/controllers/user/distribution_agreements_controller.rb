class User::DistributionAgreementsController < ApplicationController
  before_action :access_user
  before_action :set_label
  before_action :set_distribution_agreement, only: [:show, :edit, :update, :destroy]
  
  def show
    @documents = @distribution_agreement.documents
  end

  def edit
    
  end

  def new
    
    @distribution_agreement = DistributionAgreement.new
  end
  
  def create
    
    if @distribution_agreement = DistributionAgreement.create(distribution_agreement_params)
      @distribution_agreement.connect_to_label
      redirect_to user_user_label_path(@user, @label)
    else
      render :new
    end
  end
  
  
  def update
    if @distribution_agreement.update(distribution_agreement_params)
      @distribution_agreement.connect_to_label
      redirect_to user_user_label_path(@user, @label)
    else
      render :edit
    end
  end
  
  def destroy
    @label = Label.cached_find(params[:label_id])
    @distribution_agreement.destroy
    redirect_to user_user_label_path(@user, @label)
  end
  
  private
  
  def set_label
    @label = Label.cached_find(params[:label_id])
  end
  
  def set_distribution_agreement
    @distribution_agreement = DistributionAgreement.cached_find(params[:id])
  end
  
  def distribution_agreement_params
    params.require(:distribution_agreement).permit!
  end
end
