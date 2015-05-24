# cucumber features/error_triggering/guest_open_not_found.feature -r features

Feature:
As an guest I get decent errors on pages not found

  Background:
    Given there is a user with the name "Some Dude" email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And the user with the email "some-dude@digiramp.com" has a recording with the name "play me softly"
    
    
    
  @javascript  
  Scenario: As a guest I can open not found pages
  
    When I'm on the "A not existing users recording page"
    Then I can see "422 Not found"
  
    #When I visit the user "Some Dude"
    When I visit a non existing recording page the user "Some Dude"
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
