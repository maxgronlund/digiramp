class Admin::BlacklistDomainsController < ApplicationController
  before_action :set_blacklist_domain, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # GET /blacklist_domains
  # GET /blacklist_domains.json
  def index
    @blacklist_domains = BlacklistDomain.all
  end

  # GET /blacklist_domains/1
  # GET /blacklist_domains/1.json
  #def show
  #end
  #
  ## GET /blacklist_domains/new
  def new
    @blacklist_domain = BlacklistDomain.new
  end
  #
  ## GET /blacklist_domains/1/edit
  #def edit
  #end

  # POST /blacklist_domains
  # POST /blacklist_domains.json
  def create
    @blacklist_domain = BlacklistDomain.new(blacklist_domain_params)

    respond_to do |format|
      if @blacklist_domain.save
        format.html { redirect_to admin_blacklist_domains_path, notice: 'Blacklist domain was successfully created.' }
        format.json { render :show, status: :created, location: @blacklist_domain }
      else
        format.html { render :new }
        format.json { render json: @blacklist_domain.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  ## PATCH/PUT /blacklist_domains/1
  ## PATCH/PUT /blacklist_domains/1.json
  #def update
  #  respond_to do |format|
  #    if @blacklist_domain.update(blacklist_domain_params)
  #      format.html { redirect_to @blacklist_domain, notice: 'Blacklist domain was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @blacklist_domain }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @blacklist_domain.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /blacklist_domains/1
  # DELETE /blacklist_domains/1.json
  def destroy
    @blacklist_domain.destroy
    respond_to do |format|
      format.html { redirect_to admin_blacklist_domains_url, notice: 'Blacklist domain was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklist_domain
      @blacklist_domain = BlacklistDomain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blacklist_domain_params
      params.require(:blacklist_domain).permit(:domain)
    end
end
