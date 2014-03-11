#cucumber features/guests/sign_up.feature -r features

@admin_site

Feature: As an guest I can sign up

  
  Background:
    Given digiramp is prepared
    Given there is an administrator
    
  
  @javascript  
  Scenario: When I visit DigiRAMP then I can signup
    When I visit the digiramp home page
    
    When I click on the link "LOG IN"
    Then I can fill in the sign up form
    Then Does it look right?
    When I click on the button "Sign Up"
    
    Then Does it look right?
    
    When I click on the link "Add Content"

    Then Does it look right?