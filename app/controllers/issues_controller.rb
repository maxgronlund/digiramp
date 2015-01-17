class IssuesController < ApplicationController
  before_filter :access_user, only: [:create, :edit, :update, :new, :destroy]
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    forbidden({forbidden: 'login', title: 'fobar'}) unless current_user
    @issues = Issue.search( params[:query]).order('created_at desc').page(params[:page]).per(64)
    @user = current_user if current_user
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
     forbidden unless current_user
    @user = User.cached_find(params[:user_id])
  end

  # GET /issues/new
  def new
     forbidden unless current_user
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    forbidden unless current_user
    @issue = Issue.new(issue_params)
    @issue.status = 'new'
    if @issue.save
      redirect_to user_issue_path(@user, @issue)
    else
      redirect_to new_user_issue_path(@user)
    end

  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
     
    if @issue.update(issue_params)
      redirect_to user_issue_path(@user, @issue)
      #UserMailer.delay.invite_new_user_to_account(self.id, account_id, invitation_message)
    else
      redirect_to edit_user_issue_path(@user, @issue)
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
    @issue = Issue.cached_find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue).permit!
  end
end
