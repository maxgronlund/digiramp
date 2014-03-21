# cucumber features/customers/playlist/create_playlist_for_client.feature -r features

@playlist

Feature: In order to send a playlist to a client as a DigiRAMP Customer I can create a new event from the CRM section select playlist and send it


  Background:
    Given digiramp is prepared
    Given "Luna Music" is prepared and the account owner name is "Luna Lovegod" with the email "lun@music.com" and the password "nightcat" and the role "customer"
    Given there is an administrator for "Luna Music" with the name "Kit Cat" email "admin@lunamusic.com" password "fogelfaenger"

    Given these common works:
      | TITLE     | ACCOUNT       |
      | My World  | Luna Music    |
      | Get Up    | Luna Music    |
    
    Given these recordings 
      | COMMON WORK | TITLE           | ACCOUNT       | ARTIST     | BPM | INSTRUMENTAL | EXPLICIT    | 
      | My World    | My World Vocal  | Luna Music    | Artistocat | 120 | n            | n           | 
      | Get Up      | Get Up Live     | Luna Music    | Moon Boy   | 120 | n            | n           | 
  
  @javascript  
  Scenario: When I am signed in on Luna Music as administrator I can create a playlist for a customer
    When I am logged in with the email "admin@lunamusic.com" and the password "fogelfaenger"
    When I go to the Customer page for "Luna Music"
    Then I can crate a customer named "Steward Stardust" with email "steward@stardust.com" and phone "500 12 34 56"
    Then I can see "A new customer is added to your account" 
    When I click on the link "Private Playlist"
    Then Does it look right?
    Then I can create a playlist 