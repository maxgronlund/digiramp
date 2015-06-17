class Shop::ShippingAddressController < ApplicationController
  
  def new
    @user                         = current_user
    @shop_order                   = current_order
    @address                      = Address.new
    if current_user
      @address.first_name           = current_user.first_name
      @address.last_name            = current_user.last_name
      @address.city                 = current_user.city
      @address.country              = current_user.country
      @address.address_line_1       = current_user.address_line_1
      @address.address_line_2       = current_user.address_line_2
    end
    

    
  end
  
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to edit_shop_order_path(current_order.uuid), notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        render :new
        #format.html { render :new }
        #format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @user         = current_user
    @shop_order   = current_order
    #@address      = Address.find_by(addressable_id: @shop_order.id, addressable_type: @shop_order.class.name)
  end

  def update
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:first_name, :last_name, :address_line_1, :address_line_2, :city, :state, :country, :addressable_id, :addressable_type)
    end
end
