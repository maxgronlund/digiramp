class TransactionsController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:new, :create, :status]
  
  #before_action :strip_iframe_protection
  #def iframe
  #  @product = Product.find_by!(permalink: params[:permalink])
  #  @sale = Sale.new(product_id: @product)
  #end
  
  def new
    @product = Product.find_by!(permalink: params[:permalink])
    @sale = Sale.new(product_id: @product)
  end

  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @product = @sale.product
  end
  
  #def create
  #  @product = Product.find_by!(
  #    permalink: params[:permalink]
  #  )
  #  sale = @product.sales.create(
  #    amount: @product.price,
  #    email: params[:email],
  #    stripe_token: params[:stripeToken]
  #  )
  #  sale.process!
  #  if sale.finished?
  #    redirect_to pickup_url(guid: sale.guid)
  #  else
  #    flash.now[:alert] = sale.error
  #  render :new
  #  end
  #end
  def create

    product = Product.find_by!(permalink: params[:permalink])

    sale = Sale.new(amount: product.price, 
                    product_id: product.id, 
                    stripe_token: params[:stripeToken], 
                    email: params[:email]
                    )

    if sale.save!
      StripeChargerJob.perform_later(sale.guid)
      render json: { guid: sale.guid }
    else
      errors = sale.errors.full_messages
      render json: {
                    error: errors.join(" ")
                    }, status: 400
    end
  end
  
  def status
    ##'----- status ---------------'
    @sale = Sale.where(guid: params[:guid]).first
    # @sale
    render nothing: true, status: 404 and return unless @sale
    render json: {guid: @sale.guid, status: @sale.state, error: @sale.error}
  end

  #def download
  #
  #  @sale = Sale.find_by!(guid: params[:guid])
  #  resp = HTTParty.get(@sale.product.file.url)
  #  filename = @sale.product.file.url
  #  send_data resp.body, :filename => File.basename(filename), :content_type => resp.headers['Content-Type']
  #end
  
  
  private
    #def strip_iframe_protection
    #  response.headers.delete('X-Frame-Options')
    #end
end