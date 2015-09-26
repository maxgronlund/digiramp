# cucumber features/guest/open_guest_pages.feature:32 -r features

Feature:
As an guest I can see all public pages

  Background:
    #Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    Given there is a user with the name "Some Dude" email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And the user with the email "user@digiramp.com" has a recording with the name "play me softly"
    
    
    
  @javascript  
  Scenario: As a guest I can open all public pages
    When I'm on the "Public songs page"
    Then I can see "Recordings"
    
    When I'm on the "Public users page"
    Then I can see "People"
    
    When I'm on the "Public recordings page"
    Then I can see "Recordings"
    
    When I'm on the "Public opportunities page"
    Then I can see "Opportunities"
    
    When I'm on the "Public news page"
    Then I can see "News"
    
    When I'm on the "Sign up page"
    Then I can see "Sign up"
    
    When I visit the user "Some Dude"
    Then I can see "Some Dude"
    

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
