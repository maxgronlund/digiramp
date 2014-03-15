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
    When I click on the button "Sign Up"
    Then I can see "ENTER ACCOUNT NAME"
    Then Im filling in the account name with Johns Music
    When I click on the button "Save"
    Then Im filling in the user name with John Smith
    When I click on the button "Save"
    Then I can see "WELCOME"
    When I click on the button "Done"
    #When I click on the link "Add Content"
    Then I can see "ASSETS"
    Then I can see "USERS"
    When I click on the link "DASHBOARD" 
    
    Then I can see "ACCOUNTS"
    Then I can see "Johns Fine Music"
    Then I click on a link with id "edit_account_info" 
    Then I can fill in the account info
    When I click on the button "Save"
    Then I can see "John"
    Then I can see "Smith"
    Then I can see "info@johnsmit.com"
    Then I can see "500 123 456"
    Then I can see "US"
    Then I can see "Burbank Bulleward"
    Then I can see "Los Angeles"
    Then I can see "Calefornia"
    Then I can see "500600"
    Then I click on a link with id "edit_user_profile" 
    Then I can see "EDIT USER PROFILE"
    When I click on the button "Save"
    Then I can see "Success"
    Then I can see "Burbank Bulleward"
    Then I click on a link with id "Johns Fine Music" 
    
    Then I can see "USERS"
    Then I can see "ASSETS"
    Then I can see "COLLECT"
    Then I can see "PROMOTE"
    Then I can see "RIGHTS"
    Then I can see "CUSTOMERS"

    #Then Does it look right?