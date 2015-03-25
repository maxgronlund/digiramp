class ProAccountInfoController < ApplicationController
  def index
    session[:return_url] = request.url
    blog = Blog.where(identifier: 'accounts info')
                .first_or_create(identifier: 'accounts info', title: 'Accounts Info')
              
    @info_1 =    blog.blog_posts.where(identifier: 'pro account info page headding')
                                    .first_or_create(identifier: 'pro account info page headding', 
                                                     title: 'Pro Account',
                                                     teaser: 'Do more, Make money')
              
    @info_2 =    blog.blog_posts.where(identifier: 'pro account info explained')
                                    .first_or_create(identifier: 'pro account info explained', 
                                                     title: "Submit opportunities",
                                                     teaser: 'not posted on the page',
                                                     body: "Please update body ")
              
    @info_3 =    blog.blog_posts.where(identifier: 'pro account info explained2')
                                    .first_or_create(identifier: 'pro account info explained', 
                                                     title: "Submit opportunities",
                                                     teaser: 'not posted on the page',
                                                     body: "Please update body ")

  
  @body_color = '#000'
  end
end
