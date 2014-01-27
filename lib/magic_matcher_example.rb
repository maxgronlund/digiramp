require 'pp'
require_relative 'magic_matcher'
#p MagicMatcher.match_strings "cat food", "CatFood"
#group1 = ['Wohoo','cat food', 'dog food', 'duck food']
#group2 = ['CatFood', "127_DOG-FOODS.ogg", 'duckfod.mp3', 'Wohoo', 'wo hoo', 'duck food.mp3', 'duckfood.mp3']
group1 = ["catch-23"]
group2 = ["catch-22", 'Catch']
distances = MagicMatcher.match \
  objects: group1, objects_method: :to_s,
  against: group2, against_method: :to_s
  
#pp distances
distances.each do |object, matches|
  #matches = object[:against]
  p matches.map {|k,v| k}
end