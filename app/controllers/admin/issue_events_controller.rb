class Admin::IssueEventsController < ApplicationController
  before_action :set_issue_event, only: [:show, :destroy]
  before_filter :admins_only

  def index
    @issue_events = IssueEvent.all
  end

  def show
  end

  def destroy
    @issue_event.destroy
    redirect_to admin_issue_events_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_event
      @issue_event = IssueEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def issue_event_params
    #  params.require(:issue_event).permit(:title, :data, :subject_id, :subject_type)
    #end
end
