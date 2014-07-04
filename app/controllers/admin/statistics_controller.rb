class Admin::StatisticsController < ApplicationController
  before_filter :admin_only
  def index
    
    
    
    
  end

  def recordings
    @recording_uploads = Recording.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @recordings_chart = @recording_uploads.group_by_day(:created_at).count
    
   
  end

  def common_works
    @common_work_uploads = CommonWork.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @common_works_chart = @common_work_uploads.group_by_day(:created_at).count
  end

  def users
  end

  def ipis
  end
end
