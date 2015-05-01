class Account::AccountIpisController < ApplicationController
  include AccountsHelper
  #include CatalogsHelper
  
  before_action :access_account
  
  
  def index
    
  end
  
  def show
    @ipi_code = IpiCode.cached_find(params[:id])
    @ipis     = Ipi.where(ipi_code: @ipi_code.ipi_code)
  end

  def new
    @ipi_code = IpiCode.new
  end
  
  # It's not possible to create the same code two times on the same account
  def create
    ipi_code = IpiCode.where( ipi_code:   params[:ipi_code][:ipi_code],
                              account_id: @account.id,
                              ipiable_type: 'Account'
                            )
                      .first_or_create( ipi_code:   params[:ipi_code][:ipi_code],
                                        account_id: @account.id,
                                        ipiable_type: 'Account'
                              
                                       )
                      
    ipi_code.title = params[:ipi_code][:title]
    ipi_code.role  = params[:ipi_code][:role]
    ipi_code.pro   = params[:ipi_code][:pro]
    ipi_code.save!
      
    redirect_to account_account_account_ipis_path(@account)
  end

  def edit
    @ipi_code = IpiCode.cached_find(params[:id])
  end
  
  def update
    @ipi_code = IpiCode.cached_find(params[:id])
    @ipi_code.update_attributes(ipi_params)
    redirect_to account_account_account_ipis_path(@account)
  end
  
  def destroy
    @ipi_code = IpiCode.cached_find(params[:id])
    @ipi_code.destroy!
    redirect_to account_account_account_ipis_path(@account)
  end
  
private
  
  def ipi_params
     params.require(:ipi_code).permit!
  end
end
