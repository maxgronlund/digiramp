class MandrillTestersController < ApplicationController
  before_action :set_mandrill_tester, only: [:show, :edit, :update, :destroy]

  # GET /mandrill_testers
  # GET /mandrill_testers.json
  def index
    @mandrill_testers = MandrillTester.all
  end

  # GET /mandrill_testers/1
  # GET /mandrill_testers/1.json
  def show
  end

  # GET /mandrill_testers/new
  def new
    @mandrill_tester = MandrillTester.new
  end

  # GET /mandrill_testers/1/edit
  def edit
  end

  # POST /mandrill_testers
  # POST /mandrill_testers.json
  def create
    @mandrill_tester = MandrillTester.new(mandrill_tester_params)

    respond_to do |format|
      if @mandrill_tester.save
        
        
        MandrillMailer.delay.send_with_api
        
        
        format.html { redirect_to @mandrill_tester, notice: 'Mandrill tester was successfully created.' }
        format.json { render :show, status: :created, location: @mandrill_tester }
      else
        format.html { render :new }
        format.json { render json: @mandrill_tester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mandrill_testers/1
  # PATCH/PUT /mandrill_testers/1.json
  def update
    respond_to do |format|
      if @mandrill_tester.update(mandrill_tester_params)
        format.html { redirect_to @mandrill_tester, notice: 'Mandrill tester was successfully updated.' }
        format.json { render :show, status: :ok, location: @mandrill_tester }
      else
        format.html { render :edit }
        format.json { render json: @mandrill_tester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mandrill_testers/1
  # DELETE /mandrill_testers/1.json
  def destroy
    @mandrill_tester.destroy
    respond_to do |format|
      format.html { redirect_to mandrill_testers_url, notice: 'Mandrill tester was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mandrill_tester
      @mandrill_tester = MandrillTester.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mandrill_tester_params
      params.require(:mandrill_tester).permit(:email, :subject, :message)
    end
end
