
When(/^there is a blog named "(.*?)"$/) do |arg1|
  blog = FactoryGirl.create(:blog, title: 'chunky beacon', 
                                  body: 'yummy yummy', 
                                  identifier: 'beacon', 
                                  layout: 'cool')
end

When(/^there is a blog post named "(.*?)"$/) do |arg1|
  blog_post = FactoryGirl.create(:blog_post, 
                              title: 'chunky beacon', 
                              body: 'yummy yummy', 
                              image_title: 'bella vista', 
                              identifier: 'beacon', 
                              blog_id: 1,
                              position: 0,
                              link: 'http://google.com',
                              teaser: 'yummy',
                              layout: 'bright'
                              )

end