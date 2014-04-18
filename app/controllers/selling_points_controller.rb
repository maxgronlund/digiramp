class SellingPointsController < ApplicationController
  before_filter :get_blog
  def selling_point_1
    @selling_point_1_top     = BlogPost.where(identifier: 'Selling Point 1 Top', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 1 Top', blog_id: @blog.id, title: 'Selling Point 1 Top', body: 'Add content to manage')
                                         
    @selling_point_1_right     = BlogPost.where(identifier: 'Selling Point 1 Right', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 1 Right', blog_id: @blog.id, title: 'Selling Point 1 Right', body: 'Add content to manage')
    @selling_point_1_left     = BlogPost.where(identifier: 'Selling Point 1 Left', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 1 Left', blog_id: @blog.id, title: 'Selling Point 1 Left', body: 'Add content to manage')
  end

  def selling_point_2
    @selling_point_2_top     = BlogPost.where(identifier: 'Selling Point 2 Top', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 2 Top', blog_id: @blog.id, title: 'Selling Point 2 Top', body: 'Add content to manage')
                                         
    @selling_point_2_right     = BlogPost.where(identifier: 'Selling Point 2 Right', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 2 Right', blog_id: @blog.id, title: 'Selling Point 2 Right', body: 'Add content to manage')
    @selling_point_2_left     = BlogPost.where(identifier: 'Selling Point 2 Left', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 2 Left', blog_id: @blog.id, title: 'Selling Point 2 Left', body: 'Add content to manage')
  end

  def selling_point_3
    @selling_point_3_top     = BlogPost.where(identifier: 'Selling Point 3 Top', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 3 Top', blog_id: @blog.id, title: 'Selling Point 3 Top', body: 'Add content to manage')
                                         
    @selling_point_3_right     = BlogPost.where(identifier: 'Selling Point 3 Right', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 3 Right', blog_id: @blog.id, title: 'Selling Point 3 Right', body: 'Add content to manage')
    @selling_point_3_left     = BlogPost.where(identifier: 'Selling Point 3 Left', blog_id: @blog.id)\
                                         .first_or_create(identifier: 'Selling Point 3 Left', blog_id: @blog.id, title: 'Selling Point 3 Left', body: 'Add content to manage')
  end
  
private
  def get_blog
    @blog = Blog.cached_find('Selling Points')
    
    
  end
end
