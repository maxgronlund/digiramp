# cucumber features/error_triggering/member_open_not_found.feature -r features

Feature:
As an member I open non existing pages and get decent errors

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And the user with the email "user@digiramp.com" has a recording with the name "play me softly"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
    
    
    
  @javascript  
  
  Scenario: As a member I can open not found pages
    When I'm on the "A not existing message"
    Then I can see "422 Not found"
    
    
    

    

  #  
  #  When I'm on the "Account info page"
  #  Then I can see "Account info"
  #  
  #  When I'm on the "Edit account page"
  #  Then I can see "Edit account"
  #  
  #  When I'm on the "Users page"
  #  Then I can see "Users"
  #  
  #  When I'm on the "Edit user page"
  #  Then I can see "Edit user"
  #  
  #  When I'm on the "Content page"
  #  Then I can see "Content"
  #  
  #  When I'm on the "Blogs page"
  #  Then I can see "Blogs"
  #  
  #  When I'm on the "Blog page"
  #  Then I can see "Posts"
  #  
  #  When I'm on the "Edit post page"
  #  Then I can see "Edit post"
    
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
    #When I'm on the "Account info page"
    #Then I can see "Account info"
    #
