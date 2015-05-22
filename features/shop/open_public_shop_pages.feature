# cucumber features/admin/open_admin_pages.feature:107 -r features

Feature:
As an guest I can se the shop pages

  Background:
    Given I a guest
    And there is a product calles "chunky beacon"

    
    
    
  @javascript  
  Scenario: As
    When I'm on the "Public shop page"
    Then I can see "Admin"
#    
#    When I'm on the "Accounts page"
#    Then I can see "Accounts"
#    
#    When I'm on the "Account info page"
#    Then I can see "Account info"
#    
#    When I'm on the "Edit account page"
#    Then I can see "Edit account"
#    
#    When I'm on the "Users page"
#    Then I can see "Users"
#    
#    When I'm on the "Edit user page"
#    Then I can see "Edit user"
#    
#    
#    # content
#    When I'm on the "Content page"
#    Then I can see "Content"
#    
#    When I'm on the "Blogs page"
#    Then I can see "Blogs"
#    
#    When I'm on the "Blog page"
#    Then I can see "Posts"
#    
#    When I'm on the "Edit post page"
#    Then I can see "Edit post"
#    
#    When I'm on the "Tags page"
#    Then I can see "Tags"
#    
#    When I'm on the "Genres page"
#    Then I can see "Genre"
#    
#    When I'm on the "New genre page"
#    Then I can see "New genre tag"
#    
#    When I'm on the edit genre page for the "rock" tag 
#    Then I can see "Edit genre tag"
#    
#    When I'm on the "Instruments page"
#    Then I can see "Instruments"
#    
#    When I'm on the "New instrument page"
#    Then I can see "New instrument tag"
#    
#    When I'm on the edit instrument page for the "guitar" tag 
#    Then I can see "Edit instrument tag"
#    
#    When I'm on the "Moods page"
#    Then I can see "Moods"
#    
#    When I'm on the "New mood page"
#    Then I can see "New mood tag"
#    
#    When I'm on the edit mood page for the "in love" tag 
#    Then I can see "Edit mood tag"
#    
#    When I'm on the "Pro affiliations page"
#    Then I can see "Pro affiliations"
#    
#    When I'm on the "New pro affiliations page"
#    Then I can see "New pro affiliation"
#    
#    # business
#    When I'm on the "Business page"
#    Then I can see "Business"
#    
#    When I'm on the "Sales page"
#    Then I can see "Sales"
#    
#    When I'm on the "Subscriptions page"
#    Then I can see "Subscriptions"
#    
#    When I'm on the "Account types features page"
#    Then I can see "Account types features"
#    
#    When I'm on the "New account type features page"
#    Then I can see "New account type features"
#    
#    When I'm on the edit account type feature page for the "DigiRAMP-Pro" account type 
#    Then I can see "Edit account type feature"
#    
#  @javascript  
#  Scenario: As an administrator i can open the sales pages
#    When I'm on the "Sales page"
#    Then I can see "Sales"
#    
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#    #When I'm on the "Account info page"
#    #Then I can see "Account info"
#    #
#