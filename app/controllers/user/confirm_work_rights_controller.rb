class User::ConfirmWorkRightsController < ApplicationController
  before_action :access_user
  
  def index
    @common_work                = CommonWork.cached_find(params[:common_work_id])
    blog                        = Blog.cached_find('Common Work Ipi')
    @no_ipis_text               = BlogPost.cached_find('No Ipis' , blog)
    @upload_existing_contracts  = BlogPost.cached_find('Upload existing documents' , blog)
    @add_ipis                   = BlogPost.cached_find("Add IPI's" , blog)
    @im_the_only_ip             = BlogPost.cached_find("I'm the only IP" , blog)
  end
end
