# cucumber features/front_page.feature -r features

Feature:
As an guest I can se the front page

  Background:
    Given the fields for the front pages is filled in
    
  #@javascript  
  Scenario: a guest user visit the front page
    When I'm on the "Front Page"
    Then I can see "Welcome to DigiRAMP"