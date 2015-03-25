class SocialAccountInfoController < ApplicationController
  def index
    blog = Blog.where(identifier: 'accounts info')
                .first_or_create(identifier: 'accounts info', title: 'Accounts Info')
                
    @info_1 =    blog.blog_posts.where(identifier: 'social account info page headding')
                                    .first_or_create(identifier: 'social account info page headding', 
                                                     title: 'Social Account',
                                                     teaser: 'Get all the basic funcionality right now')
                
    @info_2 =    blog.blog_posts.where(identifier: 'social account info explained')
                                    .first_or_create(identifier: 'social account info explained', 
                                                     title: "Designed for creative souls",
                                                     teaser: 'not posted on the page',
                                                     body: " chunky beacon ")
                
    @info_3 =    blog.blog_posts.where(identifier: 'social account info explained2')
                                    .first_or_create(identifier: 'social account info explained2', 
                                                     title: "Designed for creative souls",
                                                     teaser: 'not posted on the page',
                                                     body: " chunky beacon ")
    @body_color = '#000'
  end
end
