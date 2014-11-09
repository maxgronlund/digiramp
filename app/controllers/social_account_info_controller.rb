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
                                                     body: "Thundercats PBR pop-up, farm-to-table before they sold out four loko normcore Shoreditch. 8-bit Thundercats sartorial cred, Etsy craft beer cray vegan small batch farm-to-table aesthetic chillwave literally cardigan shabby chic. Messenger bag pickled McSweeney's, chia leggings High Life hashtag fanny pack direct trade. Viral fixie messenger bag, wayfarers gluten-free tattooed synth bitters Bushwick pour-over gastropub Wes Anderson chambray ")
  end
end
