class ProAccountInfoController < ApplicationController
  def index

    blog = Blog.where(identifier: 'accounts info')
                .first_or_create(identifier: 'accounts info', title: 'Accounts Info')
              
    @info_1 =    blog.blog_posts.where(identifier: 'pro account info page headding')
                                    .first_or_create(identifier: 'pro account info', 
                                                     title: 'Pro Account',
                                                     teaser: 'Do more, Make monet')
              
    @info_2 =    blog.blog_posts.where(identifier: 'pro account info explained')
                                    .first_or_create(identifier: 'pro account info explained', 
                                                     title: "Submit opportunities",
                                                     teaser: 'not posted on the page',
                                                     body: "Thundercats PBR pop-up, farm-to-table before they sold out four loko normcore Shoreditch. 8-bit Thundercats sartorial cred, Etsy craft beer cray vegan small batch farm-to-table aesthetic chillwave literally cardigan shabby chic. Messenger bag pickled McSweeney's, chia leggings High Life hashtag fanny pack direct trade. Viral fixie messenger bag, wayfarers gluten-free tattooed synth bitters Bushwick pour-over gastropub Wes Anderson chambray ")

  end
end
