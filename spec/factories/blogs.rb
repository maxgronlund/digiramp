# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  
  factory :blog do |f|
    f.title 'chunky beacon'
    f.body 'yummy yummy'
    f.layout 'cool'
    f.identifier 'beacon'
    
  end
end
