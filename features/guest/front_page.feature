# cucumber features/guest/front_page.feature -r features

Feature:
As an guest I can se the front page
  Background:
    Given there is a user with the name "Some Dude" email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And the user with the email "user@digiramp.com" has a recording with the name "play me softly"

  @javascript  
  Scenario: a guest user visit the front page
    When I'm on the "Front Page"
    Then I can see "Sign up"