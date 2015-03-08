class Admin::ContractsController < ApplicationController
  
  before_filter :admin_only
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  
  def index
    @contracts = Contract.where(template: true)
  end

  def new
    @contract = Contract.new()
  end
  
  def create
    @contract = Contract.create(contract_params)
    redirect_to admin_contracts_path
  end

  def edit
  end
  
  def update
    @contract.update(contract_params)
    redirect_to admin_contracts_path
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => @contract.title.gsub(' ', '_').downcase, layout: "contracts"
      end
    end
  end

  def destroy
    @contract_id = @contract.id
    @contract.destroy
  end
  
  

private
  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    #@user = User.cached_find(params[:id])
    @contract = Contract.cached_find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contract_params
    params.require(:contract).permit!
  end
  
    
end
