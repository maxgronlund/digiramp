# cucumber features/front_page.feature -r features

Feature:
As an guest I can se the front page

  @javascript  
  Scenario: a guest user visit the front page
    When I'm on the "Front Page"
    Then I can see "Sign up"