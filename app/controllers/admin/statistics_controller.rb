class Admin::StatisticsController < ApplicationController
  before_filter :admin_only
  
  def index
    
  end

  def recordings
    
    @user = current_user
    @authorized = true
    
    # !!! optimization
    # create model to hold informations
    # run background task once a day to gather informations
    
    @recording_uploads = Recording.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @recordings_chart = @recording_uploads.group_by_day(:created_at).count
    
    
    #@playbacks      = PublicActivity::Activity.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    #@playback_chart = @playbacks.where( trackable_type: "Recording", key: "recording.playback").group_by_day(:created_at).count 
    
    @playbacks      = Playback.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @playback_chart = @playbacks.group_by_day(:created_at).count 
    
    
    @views      = RecordingView.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @views_chart = @views.group_by_day(:created_at).count 
    
   
    
    
   
  end

  def common_works
    @common_work_uploads = CommonWork.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @common_works_chart = @common_work_uploads.group_by_day(:created_at).count
    
    @views      = PublicActivity::Activity.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @views_chart = @views.where( trackable_type: "CommonWork", key: "common_work.show").group_by_day(:created_at).count 
    
  end

  def users
  end

  def ipis
  end
end
