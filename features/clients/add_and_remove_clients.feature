# cucumber features/clients/add_and_remove_clients.feature:39 -r features

@admin_site

Feature: When I'm signed in to my account I can manage clients

  
  Background:
    Given digiramp is prepared
    #Given "DigiRAMP" is prepared and the account owner is "digi@ramp.com" with password "superman"
    Given "DigiRAMP" is prepared and the account owner name is "Boss" with the email "digi@ramp.com" and the password "superman" and the role "super"
    Given there is an administrator for "DigiRAMP" with the name "Boss best friend" email "admin@istrator.com" password "batman"

    Given these users without an activated account:
      | Allan    | all@an.com            |
      | Hans     | hans@christian.com    |
      
    Given these users with an activated account:
      | John      | jo@hn.com     | Johns Account  |  dumbledore    |
      | Thomas    | to@mas.com    | Thomas Account |  alice the cat |
    
    Given these account users is added to 
      | DigiRAMP | jo@hn.com             | Client |
      | DigiRAMP | hans@christian.com    | Client |
  
  @javascript  
  Scenario: When I am signed on DigiRAMP as the account owner I can add an client there is not signed up
    When I am logged in with the email "digi@ramp.com" and the password "superman"
    When I am on the MANAGE CUSTOMERS page for "DigiRAMP"
    
    Then I click on a link with id "Users"
    Then I can see "Invite User"
    Then I am creating a customer with the email "max@digiramp.org" the name "New Customer" and the phone " 500 12 45 78"
    Then I can see "A new customer is added to your account"
    When I click on the link "CUSTOMERS"
    Then I can see "max@digiramp.org"

  
  @javascript  
  Scenario: When I am signed on DigiRAMP as the account owner I can add delete a customer that only exists on my account
    When I am logged in with the email "digi@ramp.com" and the password "superman"
    When I go the the backend users page
    Then I can see "hans@christian.com"
    Then I can see "jo@hn.com"
    When I go the the backend accounts page
    Then I can see "Johns Account"
    Then I can see "Thomas Account"
    Then I can not see "Hans"
    When I am on the MANAGE CUSTOMERS page for "DigiRAMP"
    Then I can see "jo@hn.com"
    Then I can see "hans@christian.com"
    Then I click on a link with id "delete_customer_9"
    Then I confirm popup
    Then I can see "hans@christian.com is deleted"
    When I go the the backend users page
    Then I can not see "hans@christian.com"
    
   
  @javascript  
  Scenario: When I am signed on DigiRAMP as the account owner I can add an client ther is signed up
    When I am logged in with the email "digi@ramp.com" and the password "superman"
    When I go the the backend users page
    Then I can see "jo@hn.com"
    When I go the the backend accounts page
    Then I can see "Johns Account"
    When I am on the MANAGE CUSTOMERS page for "DigiRAMP"
    When I click on the link "New Customer"
    Then I can see "NEW CUSTOMER"
    Then I am creating a customer with the email "jo@hn.com" the name "John my best Customer" and the phone " 500 12 45 78"
    Then I can see "A new customer is added to your account"
    When I click on the link "CUSTOMERS"
    Then I can see "John my best Customer"
  

  @javascript  
  Scenario: When I am signed on DigiRAMP as an administrator I can add an client there is not signed up
    When I am logged in with the email "admin@istrator.com" and the password "batman"
    When I am on the MANAGE CUSTOMERS page for "DigiRAMP"
    When I click on the link "New Customer"
    Then I can see "NEW CUSTOMER"
    Then I am creating a customer with the email "max@digiramp.org" the name "New Customer" and the phone " 500 12 45 78"
    Then I can see "A new customer is added to your account"
    When I click on the link "CUSTOMERS"
    Then I can see "max@digiramp.org"

  
  @javascript  
  Scenario: When I am signed on DigiRAMP as an administrator I can add delete a customer that only exists on my account
    When I am logged in with the email "admin@istrator.com" and the password "batman"
    When I am on the MANAGE CUSTOMERS page for "DigiRAMP"
    Then I can see "jo@hn.com"
    Then I can see "hans@christian.com"
    Then I click on a link with id "delete_customer_8"
    Then I confirm popup
    Then I can see "jo@hn.com is deleted"


    
  @javascript  
  Scenario: When I am signed on DigiRAMP as an administrator I can add an client ther is signed up
    When I am logged in with the email "digi@ramp.com" and the password "superman"
    When I am on the MANAGE CUSTOMERS page for "DigiRAMP"
    When I click on the link "New Customer"
    Then I can see "NEW CUSTOMER"
    Then I am creating a customer with the email "jo@hn.com" the name "John my best Customer" and the phone " 500 12 45 78"
    Then I can see "A new customer is added to your account"
    When I click on the link "CUSTOMERS"
    Then I can see "John my best Customer"
    
    #Then Does it look right?
    
  @javascript  
  Scenario: When I delete a client then all playlist_keys are femoved
    Then I can see "falure"
  

    
    
