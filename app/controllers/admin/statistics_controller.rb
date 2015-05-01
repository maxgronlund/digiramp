class Admin::StatisticsController < ApplicationController
  before_action :admin_only
  
  def index
    @user = current_user
    @authorized = true
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
    
    
    @views          = RecordingView.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @views_chart    = @views.group_by_day(:created_at).count 
    
   
    @likes          = Like.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @likes_chart    = @likes.group_by_day(:created_at).count 
    
    
   
  end

  def common_works
    
    @user = current_user
    @authorized = true
    
    @common_work_uploads = CommonWork.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @common_works_chart = @common_work_uploads.group_by_day(:created_at).count
    
    @views      = PublicActivity::Activity.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @views_chart = @views.where( trackable_type: "CommonWork", key: "common_work.show").group_by_day(:created_at).count 
    
  end

  def users
    @user = current_user
    @authorized = true
    
    @users_created          = User.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @users_chart            = @users_created.group_by_day(:created_at).count
    
    
    @users_sessions         = PublicActivity::Activity.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @users_sessions_chart   = @users_sessions.where( trackable_type: "User", key: "user.signed_in").group_by_day(:created_at).count 
    
    @views                  = PublicActivity::Activity.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @views_chart            = @users_sessions.where( trackable_type: "User", key: "user.show").group_by_day(:created_at).count 
    

    @relationships          = Relationship.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @relationships_chart    = @relationships.group_by_day(:created_at).count 
    

    @connections            = Connection.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @connections_chart      = @connections.group_by_day(:created_at).count 
    
    
    @messages               = Message.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @messages_chart         = @messages.group_by_day(:created_at).count 
    
    @invitations            = ClientInvitation.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @invitations_chart      = @invitations.group_by_day(:created_at).count 
    
    
  end
  
  def opportunities

    @user = current_user
    @authorized = true
    
    @opportunities_created        = Opportunity.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @opportunities_chart          = @opportunities_created.group_by_day(:created_at).count
    
    @requests_created             = MusicRequest.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @requests_chart               = @requests_created.group_by_day(:created_at).count
    
    @submissions_created          = MusicSubmission.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @submissions_chart            = @submissions_created.group_by_day(:created_at).count
    

    
    @opportunity_views          = OpportunityView.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @opportunity_views_chart    = @opportunity_views.group_by_day(:created_at).count
  end

  def ipis
    @user = current_user
    @authorized = true
  end
  
  
  def accounts
    @user = current_user
    @authorized = true
  end
  
  def pages
    @total_views                  = PageView.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago}).count
    @landing_page_views           = PageView.where(url: '/').where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @landing_page_chart           = @landing_page_views.group_by_day(:created_at).count
    

    @people_page_views            = PageView.where(url: '/users').where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @people_page_chart            = @people_page_views.group_by_day(:created_at).count
    

    @recordings_page_views        = PageView.where(url: '/recordings').where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @recordings_page_chart        = @recordings_page_views.group_by_day(:created_at).count
    

    @public_opportunities_views   = PageView.where(url: '/public_opportunities').where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @public_opportunities_chart   = @public_opportunities_views.group_by_day(:created_at).count
    

    @user_opportunities_views   = PageView.where(url: '/user/opportunities').where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @user_opportunities_chart   = @user_opportunities_views.group_by_day(:created_at).count
  end
  
  def tutorials
    
    @tutorials_index            = PageView.where(url: '/tutorials').where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @tutorials_index_chart      = @tutorials_index.group_by_day(:created_at).count
    
    @tutorial_views             = TutorialView.where("created_at >= :start_date AND created_at <= :end_date",{ start_date: 4.weeks.ago, end_date: 0.weeks.ago})
    @tutorial_views_chart       = @tutorial_views.group_by_day(:created_at).count
    
  end
end
