# cucumber features/member/member_publishers.feature -r features

Feature:
As an member I can create new publisher

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
    
    
    
  @javascript  
  Scenario: As a member I create a new publisher
    When I'm on the publishers pages for the user with the email "user@digiramp.com"
    Then I can see "Publishers"
    Then I clik on the link with the id "add-publisher"
    Then I fill in the new publisher form and save
    Then I can see "Edit legal info for"
    Then I fill in the edit publisher form and save
    Then I can see "DigiRAMP Publishing"
    Then I can see "Publishing street 1"
    Then I can see "Main building"
    Then I can see "Capitola"
    Then I can see "9600"
    Then I can see "US"
    Then I can see "CA"
    Then I can see "1 (300) 565 458"
    Then I can see "I-000000229-7"
    Then I edit the publisher
    Then I can see "Gold publising by DigiRAMP"

    #Then I clik on the link with the id "test-1"
    #Then I can see "Select module"
    #Then I select the banner module and click on next
    #Then I can see "Edit banner"
    #Then I fill in the edit banner form and save
    #Then I can see "Chunky beacon"
    #Then I edit the banner
    #Then I can see "Hello world"
    #Then I remove the banner
    #Then I can not see "Hello world"
    #Then I fill in the cms page layout form
    
    
    

    

  