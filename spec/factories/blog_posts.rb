# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  
  factory :blog_post do |f|
    f.title 'chunky beacon'
    f.body 'yummy yummy'
    f.image_title 'image_title'
    f.blog_id 1
    f.position 1
    f.link 'link'
    f.teaser 'teaser'
    f.layout 'layout'
    f.identifier 'beacon-id'
    
  end
end
