#require 'test/unit'
#include Test::Unit::Assertions

def visit_page page
  #sleep(3)
  case page
  when "Front Page"
    visit "/"
  else
    visit "page not found"
  end
end
