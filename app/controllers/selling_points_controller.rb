class SellingPointsController < ApplicationController
  before_filter :get_blog
  def selling_point_1
    @create_content     = BlogPost.where(identifier: 'Create Content', blog_id: @selling_points.id).first_or_create(identifier: 'Create Content', blog_id: @selling_points.id, title: 'Create Content', body: 'Add content to manage')
  end

  def selling_point_2
  end

  def selling_point_3
  end
private
  def get_blog
    @selling_points     = Blog.selling_points
    
  end
end
