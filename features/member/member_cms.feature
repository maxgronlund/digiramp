# cucumber features/member/member_cms.feature -r features

Feature:
As an member I can create custom pages and add content to them

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
    
    
    
  @javascript  
  
  Scenario: As a member I create a custom page
    When I'm on the admin cms pages for the user with the email "user@digiramp.com"
    Then I clik on the link with the id "new-cms-page"
    Then I fill in the new cms page form and save
    Then I can see "Edit modules"
    Then I clik on the link with the id "edit-layout"
    Then I can see "layout"
    #Then I fill in the cms page layout form
    
    
    

    

  