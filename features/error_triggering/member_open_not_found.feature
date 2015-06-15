# cucumber features/error_triggering/member_open_not_found.feature -r features

Feature:
As an member I open non existing pages and get decent errors

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And the user with the email "user@digiramp.com" has a recording with the name "play me softly"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
    
    
    
  #@javascript  
  Scenario: As a member I can open not found pages
    When I'm on the "A not existing message"
    Then I can see "404 Page not found"
    
    
    

  