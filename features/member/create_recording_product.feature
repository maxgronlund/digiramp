# cucumber features/member/create_recording_product.feature -r features


Feature:
As an member i can put recordings on sale


  Background:
    Given  there is a user with the email "account_user@digiramp.com" and the password "corect-horse-battery-stable" 
    And I'm logged in as "account_user@digiramp.com" with the password "corect-horse-battery-stable"
    And the user with the email "account_user@digiramp.com" has a recording with the name "play me softly"
    
    
    
  #Scenario: As a member I select a recording and put it in the shop
  #  When I look edit the rights for the "play me softly" recording
  #  Then I can see "Add to shop"
 

