class Admin::MandrillAccountsController < ApplicationController
  before_action :set_mandrill_account, only: [:show, :edit, :update, :destroy]

  # GET /admin/mandrill_accounts
  # GET /admin/mandrill_accounts.json
  def index
    @mandrill_accounts = MandrillAccount.all
  end

  # GET /admin/mandrill_accounts/1
  # GET /admin/mandrill_accounts/1.json
  def show
  end

  # GET /admin/mandrill_accounts/new
  def new
    @mandrill_account = MandrillAccount.new
  end

  # GET /admin/mandrill_accounts/1/edit
  def edit
  end

  def mandril_client
    @mandrill_client ||= Mandrill::API.new Rails.application.secrets.email_provider_password
  end
  
  # POST /admin/mandrill_accounts
  # POST /admin/mandrill_accounts.json
  def create
    
    
    
    
    
    begin
      
      user = User.last
      user.mandrill_account_id = "cus-" + user.slug + '-' + user.id.to_s
      

      name = user.user_name
      notes = "Free social account, signed up on " + user.created_at
      custom_quota = 1200
      result = mandril_client.subaccounts.add mandrill_account_id, name, notes, custom_quota
          # {"first_sent_at"=>"2013-01-01 15:30:29",
          #  "custom_quota"=>42,
          #  "id"=>"cust-123",
          #  "name"=>"ABC Widgets, Inc.",
          #  "sent_monthly"=>42,
          #  "created_at"=>"2013-01-01 15:30:27",
          #  "status"=>"active",
          #  "sent_total"=>42,
          #  "sent_weekly"=>42,
          #  "reputation"=>42}
    
    rescue Mandrill::Error => e
        # Mandrill errors are thrown as exceptions
        puts "A mandrill error occurred: #{e.class} - #{e.message}"
        # A mandrill error occurred: Mandrill::InvalidKeyError - Invalid API key    
        raise
    end
    
    
    
    redirect_to :back
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #@mandrill_account = MandrillAccount.new(admin_mandrill_account_params)
    #
    #respond_to do |format|
    #  if @mandrill_account.save
    #    format.html { redirect_to @mandrill_account, notice: 'Mandrill account was successfully created.' }
    #    format.json { render :show, status: :created, location: @mandrill_account }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @mandrill_account.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /admin/mandrill_accounts/1
  # PATCH/PUT /admin/mandrill_accounts/1.json
  def update
    respond_to do |format|
      if @mandrill_account.update(mandrill_account_params)
        format.html { redirect_to @mandrill_account, notice: 'Mandrill account was successfully updated.' }
        format.json { render :show, status: :ok, location: @mandrill_account }
      else
        format.html { render :edit }
        format.json { render json: @mandrill_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mandrill_accounts/1
  # DELETE /admin/mandrill_accounts/1.json
  def destroy
    @mandrill_account.destroy
    respond_to do |format|
      format.html { redirect_to mandrill_accounts_url, notice: 'Mandrill account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mandrill_account
      @mandrill_account = MandrillAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mandrill_account_params
      params.require(:mandrill_account).permit(:account_id, :notes, :custom_quota)
    end
end
