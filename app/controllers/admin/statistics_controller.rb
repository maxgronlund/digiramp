class Admin::StatisticsController < ApplicationController
  before_filter :admin_only
  def index
    
    
    
    
  end

  def recordings

    @recording_uploads = Recording.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago}).group_by_day(:created_at).count
    
    #@last_week = Recording.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 2.weeks.ago, end_date: 1.weeks.ago})
  end

  def common_works
  end

  def users
  end

  def ipis
  end
end
