class AmazonSnsController < ApplicationController
  before_action :set_amazon_sn, only: [:show, :edit, :update, :destroy]

  # GET /amazon_sns
  # GET /amazon_sns.json
  def index
    @amazon_sns = AmazonSn.all
    #
    #sns_info = Aws::SNS::Client.new(region: 'us-east-1')
    #ap sns_info.operation_names
    #
    #
    #
    #sns = Aws::SNS::Client.new({
    #  region: Rails.application.secrets.aws_s3_region,
    #  credentials: Aws::Credentials.new(Rails.application.secrets.s3_key_id, Rails.application.secrets.s3_access_key),
    #})
    #sns.initialize('arn:aws:sns:us-east-1:656201664836:my_topic')
    
    #sns.resp = sns.confirm_subscription( # required
    #                                      topic_arn: "arn:aws:sns:us-east-1:656201664836:my_topic",
    #                                      # required
    #                                      token: "token-123",
    #                                      authenticate_on_unsubscribe: "authenticateOnUnsubscribe",
    #                                    )
    #
    #
    
    #endpoint = sns.create_platform_endpoint(
    #        platform_application_arn:"arn:aws:sns:us-east-1:656201664836:my_topic",
    #        token:'ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890', 
    #        attributes: { "UserId" => "14" }
    #)
    
    
  end
  
  #auth_token
  
  #https
  
  
  # GET /amazon_sns/1
  # GET /amazon_sns/1.json
  def show
    ap params
    ap request.headers
  end
  
  
  # https://050595f0.ngrok.io/sns_hook/1
  #protect_from_forgery except: [:sns_hook]
  def sns_hook
    #ap params
    #ap request.headers["HTTP_X_AMZ_SNS_MESSAGE_TYPE"]
    #ap '======================================================='
    #ap request.headers
    #render nothing: true
  end

  # GET /amazon_sns/new
  def new
    @amazon_sn = AmazonSn.new
  end

  # GET /amazon_sns/1/edit
  def edit
  end

  # POST /amazon_sns
  # POST /amazon_sns.json
  protect_from_forgery except: [:create]
  def create

    amz_message_type                    = request.headers['HTTP_X_AMZ_SNS_MESSAGE_TYPE']
    amz_sns_topic                       = request.headers['HTTP_X_AMZ_SNS_TOPIC_ARN']
    
    #ap amz_sns_topic.to_s.downcase
    return unless !amz_sns_topic.nil? && amz_sns_topic.to_s.downcase == 'arn:aws:sns:us-east-1:656201664836:user_data_updates'
    

    request_body = JSON.parse request.body.read
    
    # if this is the first time confirmation of subscription, then confirm it
    if amz_message_type.to_s.downcase   == 'subscriptionconfirmation'
      #ap 'subscriptionconfirmation'
      send_subscription_confirmation request_body
      return
    end
    
    if amz_message_type.to_s.downcase   == 'notification'
      #ap 'notification'
      #DO WORK HERE
      ap request_body
    end
    
    return
    render nothing: true

    #@amazon_sn = AmazonSn.new(amazon_sn_params)
    #
    #respond_to do |format|
    #  if @amazon_sn.save
    #    format.html { redirect_to @amazon_sn, notice: 'Amazon sn was successfully created.' }
    #    format.json { render :show, status: :created, location: @amazon_sn }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @amazon_sn.errors, status: :unprocessable_entity }
    #  end
    #end
  end
  
  def send_subscription_confirmation(request_body)

    subscribe_url = request_body['SubscribeURL']
    ap subscribe_url
    return nil unless !subscribe_url.to_s.empty? && !subscribe_url.nil?
    subscribe_confirm = HTTParty.get subscribe_url

  end

  # PATCH/PUT /amazon_sns/1
  # PATCH/PUT /amazon_sns/1.json
  def update
    respond_to do |format|
      if @amazon_sn.update(amazon_sn_params)
        format.html { redirect_to @amazon_sn, notice: 'Amazon sn was successfully updated.' }
        format.json { render :show, status: :ok, location: @amazon_sn }
      else
        format.html { render :edit }
        format.json { render json: @amazon_sn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amazon_sns/1
  # DELETE /amazon_sns/1.json
  def destroy
    @amazon_sn.destroy
    respond_to do |format|
      format.html { redirect_to amazon_sns_url, notice: 'Amazon sn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amazon_sn
      @amazon_sn = AmazonSn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amazon_sn_params
      params.require(:amazon_sn).permit(:title)
    end
end
