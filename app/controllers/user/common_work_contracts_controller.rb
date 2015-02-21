class User::CommonWorkContractsController < ApplicationController
  before_filter :access_user

  def index

    @common_work = CommonWork.cached_find(params[:common_work_id])
    @contracts   = Contract.where(contractable_id: @common_work.id, contractable_type: 'CommonWork')
  end
  
  def show
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @contract = Contract.cached_find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => @contract.title.gsub(' ', '_').downcase, layout: "contracts"
      end
    end

  end

  def new
    @common_work = CommonWork.cached_find(params[:common_work_id])
  end

  def create
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @contract = Contract.create(contract_params)
    
    redirect_to user_user_common_work_common_work_contract_path(@user, @common_work, @contract)
  end

  def edit
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @contract = Contract.cached_find(params[:id])
  end

  def update
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @contract    = Contract.cached_find(params[:id])
    @contract.update(contract_params)
    redirect_to user_user_common_work_common_work_contracts_path(@user, @common_work)
  end
  
  def destroy
    contract = Contract.cached_find(params[:id])
    @contract_id = contract.id
    contract.destroy!
    ap params
  end
  
private 



  def contract_params
     params.require(:contract).permit!
  end
  
end
