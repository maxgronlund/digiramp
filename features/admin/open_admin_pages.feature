# cucumber features/admin/open_admin_pages.feature:36 -r features

Feature:
As an administrator i can se all the pages

  Background:
    Given I am the administrator
    And I am logged in
    And there is a blog named "chunky beacon"
    And there is a blog post named "fried chunky beacon"
    
    
    
  @javascript  
  Scenario: As an administrator i can open all admin the pages
    When I'm on the "Admin page"
    Then I can see "Admin"
    
    When I'm on the "Accounts page"
    Then I can see "Accounts"
    
    When I'm on the "Account info page"
    Then I can see "Account info"
    
    When I'm on the "Edit account page"
    Then I can see "Edit account"
    
    When I'm on the "Users page"
    Then I can see "Users"
    
    When I'm on the "Edit user page"
    Then I can see "Edit user"
    
    When I'm on the "Content page"
    Then I can see "Content"
    
    When I'm on the "Blogs page"
    Then I can see "Blogs"
    
    When I'm on the "Blog page"
    Then I can see "Posts"
    
    When I'm on the "Edit post page"
    Then I can see "Edit post"
    
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
