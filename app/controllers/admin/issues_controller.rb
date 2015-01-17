class Admin::IssuesController < ApplicationController
  before_filter :admin_only
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.search( params[:query]).order('created_at desc').page(params[:page]).per(64)
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    
  end

  # GET /issues/new
  def new
   
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    

  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    if @issue.update(issue_params)
      
      
      if @issue.status == 'Resolved'
        # send email 
        @issue.resolved
      end
      
      
      
      redirect_to admin_issue_path( @issue)
      
    else
      redirect_to edit_admin_issue_path( @issue)
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue_id = @issue.id
    @issue.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit!
    end
end
