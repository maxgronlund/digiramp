class Admin::InstrumentsController < ApplicationController
  before_filter :admin_only

  def index
    @instruments = Instrument.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(32)
  end
  
  def new
    @instrument = Instrument.new
  end
  
  def create
    if @instrument = Instrument.create(instrument_params)
      flash[:success]   = { title: 'Success', body: 'Instrument created' }
      redirect_to_return_url admin_instruments_path
    else
      redirect_to :back
    end
    
  end

  def edit
    @instrument = Instrument.cached_find(params[:id])
    
  end
  
  def update
    
    @instrument = Instrument.find(params[:id])
    if @instrument.update_attributes(instrument_params)
      flash[:success]   = { title: 'Success', body: 'Instrument updated' }
      redirect_to_return_url admin_instruments_path
    else
      redirect_to :back
    end
    
  end
  
  def destroy
    @instrument = Instrument.find(params[:id])
    @instrument.destroy!
    flash[:success]   = { title: 'Success', body: 'Instrument deleted' }
    redirect_to_return_url admin_instruments_path
  end
private
  def instrument_params
    params.require(:instrument).permit! if current_user.can_edit?
  end
end
