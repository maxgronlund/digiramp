module MagicMatcher
  require 'levenshtein'
  require_relative 'magic_matcher/string_methods'
  
  class << self
    include StringMethods
    
    def match_strings s, t
      a = seperators_as_spaces(without_ext(s)).downcase.strip
      b = seperators_as_spaces(without_ext(t)).downcase.strip
      
            
      if !has_spaces?(a) || !has_spaces?(b)
        a = letters_only a
        b = letters_only b
      end
      
      levenshtein = Levenshtein.normalized_distance(a, b)
      contains_substring = container a, b
      totally_equal = without_ext(s.downcase.strip) == without_ext(t.downcase.strip)
      number_distance = numbers(s).join('') <=> numbers(t).join('')
      
      {
        levenshtein:        levenshtein,
        contains_substring: contains_substring,
        totally_equal:      totally_equal,
        number_distance:    number_distance,
        warning:            number_distance > 0 || levenshtein > 0.15 
      }
    end
    
    def match options
      objects        = options[:objects]
      objects_method = options[:objects_method]
      against        = options[:against]
      against_method = options[:against_method]
      
      matches = {}
      
      objects.uniq.each do |object1|
        matches[object1] = []
        against.uniq.each do |object2|
          s = object1.send objects_method
          t = object2.send against_method
          matches[object1]  << {against: object2, distance: match_strings(s,t)}
        end
        matches[object1].sort! { |a,b|
          if b[:distance][:totally_equal]
            1
          elsif a[:distance][:totally_equal]
            -1
          else
            levenshtein = a[:distance][:levenshtein] <=> b[:distance][:levenshtein]
            if levenshtein == 0
              number_distance = a[:distance][:number_distance] <=> b[:distance][:number_distance]
              if number_distance != 0
                number_distance
              else
                substring_compare a, b
              end
            else
              levenshtein
            end
          end
        }
      end
      
      matches
    end
    
    def substring_compare a, b
      if b[:distance][:contains_substring] && !a[:distance][:contains_substring]
        1
      elsif a[:distance][:contains_substring] && !b[:distance][:contains_substring]
        -1
      else
        0
      end
    end
  end
end

__END__
puts without_spaces("a cat bug") == "acatbug" # => true

p container "123", "2"
p letters_only without_ext 'super-flying-cats.mp3'

p Levenshtein.distance "12345", "12356"