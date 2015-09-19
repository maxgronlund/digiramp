class User::DistributionAgreementsController < ApplicationController
  before_action :access_user
  def show
  end

  def edit
    @label = Label.cached_find(params[:label_id])
    @distribution_agreement = DistributionAgreement.cached_find(params[:id])
  end

  def new
    @label = Label.cached_find(params[:label_id])
    @distribution_agreement = DistributionAgreement.new
  end
  
  def create
    @label = Label.cached_find(params[:label_id])
    if @distribution_agreement = DistributionAgreement.create(distribution_agreement_params)
      @distribution_agreement.connect_to_label
      redirect_to user_user_label_path(@user, @label)
    else
      render :new
    end
  end
  
  
  def update
    @label = Label.cached_find(params[:label_id])
    @distribution_agreement = DistributionAgreement.cached_find(params[:id])
    if @distribution_agreement.update(distribution_agreement_params)
      @distribution_agreement.connect_to_label
      redirect_to user_user_label_path(@user, @label)
    else
      render :edit
    end
  end
  
  def destroy
    @label = Label.cached_find(params[:label_id])
    @distribution_agreement = DistributionAgreement.cached_find(params[:id])
    @distribution_agreement.destroy
    redirect_to user_user_label_path(@user, @label)
  end
  
  private
  
  def distribution_agreement_params
    params.require(:distribution_agreement).permit!
  end
end
