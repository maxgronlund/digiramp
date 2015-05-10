FactoryGirl.define do
  
  factory :genre do |f|
    f.title "pop"
    f.user_tag false
    f.category "Popular Music"
    f.ingrooves_category "Rock"
    f.ingrooves_genre "Rock"
    f.itunes_category "Rock"
    f.itunes_genre "Rock"
  end
end