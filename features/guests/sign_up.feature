#cucumber features/guests/sign_up.feature -r features

@admin_site

Feature: As an guest I can sign up

  
  Background:
    
    
  
  @javascript  
  Scenario: When I visit DigiRAMP then I can signup
    When I visit the digiramp home page
    Then I can fill in the sign up form
    When I click on the button "Sign Up"

    Then Does it look right?