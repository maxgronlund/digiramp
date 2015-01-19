class Admin::EmailGroupsController < ApplicationController
  before_action :set_email_group, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only
  def index
    @email_groups = EmailGroup.all
    EmailGroup.where(  title: 'Opportunities', 
                       identifier: 'opportunities')
              .first_or_create(  title: 'Opportunities', 
                                identifier: 'opportunities',
                                uuid: UUIDTools::UUID.timestamp_create().to_s,
                                subscripeable: true,
                                body: 'Get notified when new opportunities are posted on DigiRAMP',
                                subscripeable: true)
    

    
  end

  def show
  end

  def new
    @email_group = EmailGroup.new
  end

  def edit
  end

  def create
    @email_group = EmailGroup.new(email_group_params)
    @email_group.save!
    redirect_to admin_email_group_path @email_group
  end

  def update
    if @email_group.update(email_group_params)
      redirect_to admin_email_group_path @email_group
    end
  end

  def destroy
    @email_group.destroy
    redirect_to admin_email_groups_path
  end
  
  def add_all_members
    @email_group = EmailGroup.find(params[:email_group_id])

    User.all.each do |user|
      
      if EmailValidator.validate( user.email )
        MailListSubscriber.where(user_id: user.id, email_group_id: @email_group.id)
                          .first_or_create(user_id: user.id, email_group_id: @email_group.id)
      end
    end
    
    redirect_to admin_email_group_email_recipients_path(@email_group)
  end
  
  def remove_all_subscribers
    @email_group = EmailGroup.find(params[:email_group_id])
    @email_group.mail_list_subscribers.destroy_all
    redirect_to admin_email_group_email_recipients_path(@email_group)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_group
      @email_group = EmailGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_group_params
      params.require(:email_group).permit!
    end
end
