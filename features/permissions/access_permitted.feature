# cucumber features/permissions/access_permitted.feature:32 -r features

@admin_site

Feature: When I'm signing in to an account I can only se stuff I am permitted to if I try to open a url to a place where I dont have permission I got an error

  
  Background:
    Given digiramp is prepared
    Given "DigiRAMP" is prepared and the account owner name is "Boss" with the email "digi@ramp.com" and the password "joker" and the role "super"
    Given there is an administrator for "DigiRAMP" with the name "Boss best friend" email "admin@istrator.com" password "batman"

    
    Given "Luna Music" is prepared and the account owner name is "Luna Lovegod" with the email "lun@music.com" and the password "nightcat" and the role "customer"
    Given there is an administrator for "Luna Music" with the name "Kit Cat" email "admin@lunamusic.com" password "fogelfaenger"

    Given these users with an activated account:
      | John      | jo@hn.com     | Johns Account  |  dumbledore    |
      | Thomas    | to@mas.com    | Thomas Account |  alice the cat |
    
    Given these account users is added as associate to 
      | DigiRAMP   | jo@hn.com        | Associate | access_recordings | access_works | access_rights | access_documents | na             |
      | Luna Music | to@mas.com       | Associate | na                | na           | na            | na               | access_collect |
  
  @javascript  
  Scenario: When I am signed in on DigiRAMP as administrator I can not access Luna Music
    When I am logged in with the email "admin@istrator.com" and the password "batman"
    When I go to the account "Luna Music"
    Then I can see "You are not permitted to view the page"
    When I go to the account "DigiRAMP"
  
  @javascript  
  Scenario: When I am signed in as the super user I can access all accounts
    When I am logged in with the email "digi@ramp.com" and the password "joker"
    When I go to the account "Luna Music"
    Then I can see "LUNA MUSIC"
    When I go to the account "DigiRAMP"
    Then I can see "DIGIRAMP"
    
    
    
    
    
    #Then Does it look right?
   